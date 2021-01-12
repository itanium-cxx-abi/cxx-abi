? diffs.txt
Index: abi.html
===================================================================
RCS file: /home/cvs/Repository/cxx-abi/abi.html,v
retrieving revision 1.81
diff -c -5 -p -r1.81 abi.html
*** abi.html	17 Feb 2005 20:36:57 -0000	1.81
--- abi.html	4 May 2005 23:34:31 -0000
*************** or destructor,
*** 2660,2672 ****
  the caller allocates space for a temporary,
  and passes a pointer to the temporary as an implicit
  first parameter
  preceding both the <code>this</code> parameter and user parameters.
  The callee constructs the return value into this temporary.
- On Itanium, the pointer is passed in <code>out0</code>,
- different from other large class result buffer pointers,
- passed in <code>r8</code>.
  
  <p>
  A result of an empty class type will be returned as though it were
  a struct containing a single char,
  i.e. <code>struct S { char c; };</code>.
--- 2660,2669 ----
*************** unwind table location.
*** 4957,4966 ****
--- 4954,4967 ----
  <p> <hr> <p>
  
  <p>This version of this document is $Revision: 1.81 $.  No special
  significance should be attached to the form of the revision number; it
  is simply a identifying number.</p>
+ 
+ <p>
+ <font color=blue>[050405]</font>
+ Remove use of <code>out0</code> for by-value return types on Itanium.
  
  <p>
  <font color=blue>[050211]</font>
  Reverse treatment of ambiguous arguments to __cxa_demangle (3.4).
  
