Index: abi.html
===================================================================
RCS file: /home/cvs/Repository/cxx-abi/abi.html,v
retrieving revision 1.77
diff -c -5 -p -r1.77 abi.html
*** abi.html	17 Jul 2004 18:03:11 -0000	1.77
--- abi.html	15 Sep 2004 20:41:00 -0000
*************** extern "C" void __cxa_vec_delete (
*** 3309,3328 ****
  	    size_t element_size,
  	    size_t padding_size,
  	    void (*destructor) ( void *this ) );
  </pre></code></dt>
  <dd>
  If the <code>array_address</code> is <code>NULL</code>, return
  immediately.  Otherwise, given the (data) address of an array, the
  non-negative size of prefix padding for the cookie, and the size of
  its elements, call the given destructor on each element, using the
! cookie to determine the number of elements, and then delete the space.
! If the destructor throws an exception, rethrow after destroying the
! remaining elements if possible.  If the destructor throws a second
! exception, call <code>terminate()</code>.  If padding_size is 0, the
! destructor pointer must be NULL.  If the destructor pointer is NULL,
! no destructor call is to be made.
  </dd>
  
  <dt><code><pre>
  extern "C" void __cxa_vec_delete2 (
  	    void *array_address,
--- 3309,3343 ----
  	    size_t element_size,
  	    size_t padding_size,
  	    void (*destructor) ( void *this ) );
  </pre></code></dt>
  <dd>
+ <p>
  If the <code>array_address</code> is <code>NULL</code>, return
  immediately.  Otherwise, given the (data) address of an array, the
  non-negative size of prefix padding for the cookie, and the size of
  its elements, call the given destructor on each element, using the
! cookie to determine the number of elements, and then delete the space
! by calling <code>::operator delete[](void *)</code>.
! If the destructor throws an exception, rethrow after (a) destroying
! the remaining elements, and (b) deallocating the storage.  If the
! destructor throws a second exception, call <code>terminate()</code>.
! If padding_size is 0, the destructor pointer must be NULL.  If the
! destructor pointer is NULL, no destructor call is to be made.
! </p>
! 
! <p>
! <img src=warning.gif alt="<b>NOTE</b>:">
! The intent of this function is to permit an implementation to call
! this function when confronted with an expression of the form
! <code>delete[] p</code> in the source code, provided that the default
! deallocation function can be used.  Therefore, the semantics
! of this function are consistent with those required by the standard.
! The requirement that the deallocation function be called even if the
! destructor throws an exception derives from the resolution to DR 353
! to the C++ standard, which was adopted in April, 2003.
! </p>
  </dd>
  
  <dt><code><pre>
  extern "C" void __cxa_vec_delete2 (
  	    void *array_address,
