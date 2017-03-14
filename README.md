# The Itanium C++ ABI

This is the central repository for discussion and development of the
[Itanium C++ ABI specfication](http://itanium-cxx-abi.github.io/cxx-abi/).

## Change process

C++ is a compiled language, and binary compatibility between different
compilations is a core goal of the Itanium C++ ABI.  Many details of
the ABI cannot be changed without breaking compatibility in some way,
and we cannot accept proposals to make such changes.  If you are hoping
to, say, change the default dispatch algorithm for virtual functions
on Linux, you're not going to make much headway here.   That said,
there are several major categories of proposal which we can accept:

* Proposals that are clearly identified as being for "future ABIs".
  Not all projects demand the same level of rigor in binary
  compatibility, and sometimes there are clear opportunities for
  "breaks", such as when an operating system is ported to a new
  architecture.  We are collecting recommendations for changes to
  make in such a future ABI.

* Proposals to specify the implementation of new language features.
  New language features do not generally affect backward
  compatibility because they are usually not used in older code.

  (There are exceptions.  Sometimes new language rules change the
  interpretation of old code, and new language features can be
  adopted in header declarations for old code.  It is part of an
  ABI maintainer's job to evaluate the impact of such changes and
  provide guidance to the language committee.)

* Proposals to fix a bug in the ABI.  It sometimes happens that
  the ABI overlooks some possibility in a way that causes code
  to be miscompiled.  (Most commonly, two declarations that the
  language considers different are mangled the same way because
  of missing information or ambiguities in the mangling grammar.)
  Proposals to fix such problems are generally welcome, although
  they must be designed carefully to minimize binary
  incompatibilities.

* Editorial and organizational improvements.  The ABI specification
  should, ideally, be a clear guide to implementers and a helpful
  reference for sophisticated users.  Changes to clarify wordings,
  improve document structure, and so on are always welcome.

Non-editorial changes should be proposed by creating a new issue
via the standard GitHub interface.  The issue description should
explain the problem and (if applicable) the proposed solution.
The solution can be discussed in the comments.  When, eventually,
a pull request is submitted for the issue, it will be accepted
after consensus has been reached and several weeks have passed
to give all contributors an opportunity to comment.  (Changes
which have already been discussed on cxx-abi-dev and simply
haven't been merged into the repository do not need to undergo
this additional waiting period.)

Editorial changes should just be submitted as pull requests.

## Additional documents hosted here

* [Compact Exception Tables for MIPS ABIs](MIPSCompactEH.pdf)
