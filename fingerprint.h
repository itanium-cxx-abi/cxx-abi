/***********************************************************************

 File:   fingerprint.h
 Author: Mark Mitchell
 Date:   05/31/1998

 Contents: A port of the Modula-3 fingerpinting module to C.

 Copyright (c) 1998 Mark Mitchell.  All rights reserved.

 Redistribution and use in source and binary forms are permitted
 provided that the above copyright notice and this paragraph are
 duplicated in all such forms and that any documentation, advertising
 materials, and other materials related to such distribution and use
 acknowledge that the software was developed by Mark Mitchell.  The
 name Mark Mitchell may not be used to endorse or promote products
 derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
 MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

***********************************************************************/

#ifndef FINGERPRINT_H
#define FINGERPRINT_H

#ifdef __cplusplus
extern "C" {
#endif /* ifdef __cplusplus */

/***********************************************************************
  Notes									
***********************************************************************/

/* Origins
   -------

   The contents of this module are derived from the fingerprinting
   routines provided in the Digital Equipment Corporation Modula-3
   sources.  The entire contents of the source distribution are
   available at:

     http://www.research.digital.com/SRC/m3sources/html/INDEX.html

   The fingerprinting algorithm is just a hashing algorithm, but it is
   a very good one: the probability of collisions is provably
   negligible.  There is a precise description of this property at the
   above URL.  

   Implementation
   --------------

   The code below contains two variants: one for machines which have a
   native 64-bit little-endian integral type, and one for all other
   systems.  (Actually, the "portable" code will not work on those
   systems which have bytes containing more than 8 bits.  In addition,
   neither version of the code will work if there is no integer type
   with the same number of bits as all pointer values.  This may occur
   either if some pointer types have more or less bits than others, or
   if there are no integer types with the right number of bits.) 

   Configuration
   -------------

   Before including this file, you may define the following macros:

     FINGERPRINT_INTEGRAL_TYPE

       If this macro is defined, it must be the name of a signed,
       64-bit, little-endian integral type.  If your system has such a
       type, you should use this macro, as it will result in faster
       code. 

     FINGERPRINT_INT_32_TYPE
     
       This macro may be defined to the name of a signed 32-bit
       integral type.  If this macro is not defined, `int' is used
       instead.  

     FINGERPRINT_POINTER_INT_TYPE 

       This macro may be defined to the name of a signed integral type
       with the same number of bits as pointer values.  If this macro
       is not defined, `int' is used instead.  

     FINGERPRINT_LITTLE_ENDIAN

       If this macro is defined to 1, the system is little-endian.  If
       this macro is defined to 0, the system is big-endian.  This
       macro may be left undefined, in which case the fingerprinting
       routines will determine the endianness at run-time.  If
       FINGERPRINT_INTEGRAL_TYPE is defined, it is assumed that the
       system is little-endian; you must not set this flag in that
       case.  

   Testing
   -------

   When the fingerprint module is initialized, if will perform some
   basic consistency checking, unless NDEBUG is defined.  In addition,
   you can build fingerprint.c, defining FINGERPRINT_TEST, to build a
   small program which tests the basic functionality of the
   fingerprint module.  You should undertake this procedure if running
   the fingerprint module in a configuration you have not used 
   before.  */

/***********************************************************************
  Macros								
***********************************************************************/

/* FINGERPRINT_USE_INTEGRAL_TYPE is defined if we have a 64-bit
   integral type to use for fingerprints.  */

#ifdef FINGERPRINT_INTEGRAL_TYPE
#define FINGERPRINT_USE_INTEGRAL_TYPE 1
#else /* ifndef FINGERPRINT_USE_INTEGRAL_TYPE */
#define FINGERPRINT_USE_INTEGRAL_TYPE 0
#endif /* ifdef FINGERPRINT_USE_INTEGRAL_TYPE */

/***********************************************************************
  Types									
***********************************************************************/

/* A fingerprint_byte_t is an unsigned 8-bit integral type:

     TYPE Byte = BITS 8 FOR [0..255];  */

typedef unsigned char fingerprint_byte_t;

/* A fingerprint_word_t w represents a sequence of Word.Size bits
   w(0), ..., w(Word.Size - 1).  It also represents the  unsigned
   number sum of 2^(i) * w(i) for i in 0, ..., Word.Size - 1.  

   The idea is that this type will occupy the natural word size of the
   machine.  */

typedef unsigned int fingerprint_word_t;

#if !FINGERPRINT_USE_INTEGRAL_TYPE
/* A fingerprint_t is a 64-bit checksum:
 
     TYPE T = RECORD
	 byte: ARRAY [0..7] OF BITS 8 FOR [0..255]
       END;  */

typedef struct fingerprint_t {
  fingerprint_byte_t
                byte[8];
			/* Externally, a fingerprint is an opaque
			   object of 64 bits.  */
} fingerprint_t;

/* Returns the address of the first byte of the fingerprint.  Use this
   macro to access the bytes in a configuration-independent manner.  */

#define FINGERPRINT_BYTE(fp) (&((fp).byte[0]))

#else /* FINGERPRINT_USE_INTEGRAL_TYPE */
typedef FINGERPRINT_INTEGRAL_TYPE fingerprint_t;
#define FINGERPRINT_BYTE(fp) ((fingerprint_byte_t*) &(fp))
#endif /* !FINGERPRINT_USE_INTEGRAL_TYPE */

/***********************************************************************
  Variables
***********************************************************************/

#if !FINGERPRINT_USE_INTEGRAL_TYPE
extern const fingerprint_t 
                fingerprint_zero;
                        /* This value is not the fingerprint of any
			   text.  */
#else /* FINGERPRINT_USE_INTEGRAL_TYPE */
#define fingerprint_zero ((fingerprint_t) 0)
#endif /* FINGERPRINT_USE_INTEGRAL_TYPE */

extern /*const*/ fingerprint_t 
                fingerprint_of_empty;
			/*  The fingerprint of the empty text.  This
			    value should be thought of as const, but
			    cannot be, since it must be dynamically
			    initialized.   */

/***********************************************************************
  Functions
***********************************************************************/

/* Initialize the fingerprint module.  This routine must be called
   before any other routine in this module.  */
extern void fingerprint_init (void);

/* Return the fingerprint of TEXT.  */
extern fingerprint_t fingerprint_from_text (const char* text);

/* Return the fingerprint of the ordered pair (FP1, FP2).  */
extern fingerprint_t fingerprint_combine (fingerprint_t fp1,
					  fingerprint_t fp2);

/* Return of the fingerprint of T and TEXT where T is the text whose
   fingerprint is FP.  */
extern fingerprint_t fingerprint_from_chars (const char*   text,
					     fingerprint_t fp);

/* Return FP1 == FP2.  */
#if !FINGERPRINT_USE_INTEGRAL_TYPE
extern int fingerprint_equal (fingerprint_t fp1,
			      fingerprint_t fp2);
#else /* FINGERPRINT_USE_INTEGRAL_TYPE */
#define fingerprint_equal(fp1, fp2) ((fp1) == (fp2))
#endif /* !FINGERPRINT_USE_INTEGRAL_TYPE */

/* Return FP1 == FP2.  This function is provided for use by
   applications which use pointers to functions when creating
   container objects, or other such data structures.  Unlike
   fingerprint_equal, fingerprint_equal_f is always a function.  */
extern int fingerprint_equal_f (fingerprint_t fp1,
				fingerprint_t fp2);

/* Return a hash code for FP.  */
extern fingerprint_word_t fingerprint_hash (fingerprint_t fp);

#ifdef __cplusplus
}
#endif /* ifdef __cplusplus */

#endif /* FINGERPRINT_H */
