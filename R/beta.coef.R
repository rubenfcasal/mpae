#····································································
#   beta.coef (mpae package)
#····································································
#   Ruben Fernandez-Casal
#   Created: Feb 2024
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

#····································································
# beta.coef(object, ...) ----
#····································································
#' Beta coefficients
#'
#' Computes the beta (regression) coefficients, also called standardized
#' coefficients or beta weights, to quantify the importance (the effect) of the
#' predictors on the dependent variable in a multiple regression analysis where
#' the variables are measured in different units.
#'
#' The beta weights are the coefficient estimates resulting from a regression
#' analysis where the underlying data have been standardized so that the
#' variances of dependent and explanatory variables are equal to 1.
#' Therefore, standardized coefficients are unitless and refer to how many
#' standard deviations a dependent variable will change, per standard deviation
#' increase in the predictor variable.
#' See \url{https://en.wikipedia.org/wiki/Standardized_coefficient} or
#' [QuantPsyc::lm.beta](https://rdrr.io/cran/QuantPsyc/man/lm.beta.html).
#' @param object an object for which the extraction of model coefficients is
#' meaningful.
#' @param ... further arguments passed to or from other methods.
#' @seealso [coef()]
#' @export
beta.coef <- function(object, ...){
  UseMethod("beta.coef")
}


#' @rdname beta.coef
#' @method beta.coef default
#' @param complete for the default (used for lm, etc) and aov methods: logical
#' indicating if the full coefficient vector should be returned also in case of
#' an over-determined system where some coefficients will be set to [NA].
#' @details Based on `QuantPsyc::lm.beta()`
#' @examples
#' fit <- lm(fidelida ~ velocida + calidadp, hbat)
#' coef(fit)
#' beta.coef(fit)
#' fit2 <- lm(scale(fidelida) ~ scale(velocida) + scale(calidadp), hbat)
#' coef(fit2)
#' @export
beta.coef.default <- function(object, complete = FALSE, ...) {
    cf <- object$coefficients[-1]
    sx <- sapply(object$model[-1], sd)
    sy <- sd(object$model[[1]])
    cf <- cf * sx /  sy
    if (complete)
        cf
    else cf[!is.na(cf)]
}


