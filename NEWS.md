# mpae (development version)

* Added `()`.

* Fixed small bug in `()`
  ().
  
* Small changes in `()`
  ().

# mpae 0.1-1 (2024-03-15) 

* Added body fat datasets: `bodyfat.raw`, `bodyfat` and `bfan`.

* Added `pred.plot()` S3 generic function (and methods).

  - `obs.pred.plot()` renamed as `pred.plot.default()` 
     (the default method; for regression).

  -  Added `pred.plot.factor()` (for classification).

* S3 generic `beta.coef()` renamed as `scaled.coef()`, 
  with an additional argument `scaled.response = TRUE`
  in the default method.

* Added packages used in the book in the `Suggests` field of DESCRIPTION.


# mpae 0.1-0 (2024-02-01) 

* Initial version in package form.
  
