---
title: Starting ACL2 in Earnest
date: 2020-10-10
---

## What about more complicated properties? 

## `defunc` functions

`defunc` short-hand version

```lisp
:input-contract ...
:output-contract ...
```

# property-based testing 

`(test? (equal (app (list x y) (list)) (list x y)))`

(test? (implies (natp n) (equal (even-integerp n) (even-natp n))))

# let is basically local. 

let, let* 
