Index: abi.html
===================================================================
RCS file: /home/cvs/Repository/cxx-abi/abi.html,v
retrieving revision 1.75
diff -c -5 -p -r1.75 abi.html
*** abi.html	28 Nov 2003 20:58:26 -0000	1.75
--- abi.html	20 Feb 2004 07:57:01 -0000
*************** No entity is added to the dictionary twi
*** 4593,4602 ****
--- 4593,4612 ----
  
  <p>
  The type of a non-static member function is considered to be
  different, for the purposes of substitution, from the type of a
  namespace-scope or static member function whose type appears similar.
+ The types of two non-static member functions are considered to be
+ different, for the purposes of substitution, if the functions are
+ members of different classes.  In other words, for the purposes of
+ substitution, the class of which the function is a member is
+ considered part of the type of function.
+ </p>
+ 
+ <p>
+ <img src=warning.gif alt="<b>NOTE</b>:">
+ <i>
  Therefore, in the following example:
  <blockquote><code><pre>
  typedef void T();
  struct S {};
  void f(T*, T (S::*)) {}
*************** the function <code>f</code> is mangled a
*** 4606,4615 ****
--- 4616,4626 ----
  to by the second parameter is not considered the same as the type of
  the function pointed to by the first parameter.  Both function types
  are, however, entered the substitution table; subsequent references to
  either variant of the function type will result in the use of
  substitutions.
+ </i></p>
  
  <p>
  Substitution is according to the production:
  
  <pre><font color=blue><code>
*************** unwind table location.
*** 4913,4922 ****
--- 4924,4938 ----
  <p> <hr> <p>
  
  <p>This version of this document is $Revision: 1.75 $.  No special
  significance should be attached to the form of the revision number; it
  is simply a identifying number.</p>
+ 
+ <p>
+ <font color=blue>[040219}</font>
+ Clarify substition of member function types.
+ </p>
  
  <p>
  <font color=blue>[031128]</font>
  Fix alphabetization of company names.
  
