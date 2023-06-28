Index: abi.html
===================================================================
RCS file: /home/cvs/Repository/cxx-abi/abi.html,v
retrieving revision 1.78
diff -c -5 -p -r1.78 abi.html
*** abi.html	24 Sep 2004 03:47:55 -0000	1.78
--- abi.html	26 Oct 2004 01:09:26 -0000
*************** sharing a virtual pointer with the deriv
*** 228,242 ****
  
  <p>
  <a name="POD" />
  <dt> <i>POD for the purpose of layout</i><dt>
  <dd>
! A type is considered a POD for the purposes of layout if it is a POD
! type (in the sense of [basic.types]), and is not a POD-struct or
! POD-union (in the sense of [class]) with a bitfield member whose declared
! width is wider than the declared type of the bitfield
! </dd>
  </p>
  
  <p>
  <dt> <i>primary base class</i> </dt> <dd> For a dynamic class, the
  unique base class (if any) with which it shares the virtual pointer at
--- 228,258 ----
  
  <p>
  <a name="POD" />
  <dt> <i>POD for the purpose of layout</i><dt>
  <dd>
! <p>
! In general, a type is considered a POD for the purposes of layout if
! it is a POD type (in the sense of ISO C++ [basic.types]).  However, a
! POD-struct or POD-union (in the sense of ISO C++ [class]) with a
! bitfield member whose declared width is wider than the declared type
! of the bitfield is not a POD for the purpose of layout.  Similarly, an
! array type is not a POD for the purpose of layout if the element type
! of the array is not a POD for the purpose of layout.  Where references
! to the ISO C++ are made in this paragraph, the Technical Corrigendum 1
! version of the standard is intended.
! 
! <p>
! <img src=warning.gif alt="<b>NOTE</b>:">
! The ISO C++ standard published in 1998 had a different definition of
! POD types.  In particular, a class with a non-static data member of
! pointer-to-member type was not considered a POD in C++98, but is
! considered a POD in TC1.  Because the C++ standard requires that
! compilers not overlay the tail padding in a POD, using the C++98
! definition in this ABI would prevent a conforming compiler from
! correctly implementing the TC1 version of the C++ standard.
! Therefore, this ABI uses the TC1 definition of POD.</dd>
  </p>
  
  <p>
  <dt> <i>primary base class</i> </dt> <dd> For a dynamic class, the
  unique base class (if any) with which it shares the virtual pointer at
*************** unwind table location.
*** 4939,4948 ****
--- 4955,4972 ----
  <p> <hr> <p>
  
  <p>This version of this document is $Revision: 1.78 $.  No special
  significance should be attached to the form of the revision number; it
  is simply a identifying number.</p>
+ 
+ <p>
+ <font color=blue>[041025]</font>
+ Indicate that the TC1 definition of POD is intended in the section
+ defining a &quot;POD for the purpose of layout&quot;.  Clearly
+ indicate that an array whose elements are not PODs for the purpose of
+ layout is itself not a POD for the purpose of layout.
+ </p>
  
  <p>
  <font color=blue>[040923]</font>
  Clarify behavior of <code>__cxa_vec_delete</code>.
  </p>
