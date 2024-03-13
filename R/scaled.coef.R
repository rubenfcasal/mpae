#····································································
#   scaled.coef (mpae package)
#····································································
#   Ruben Fernandez-Casal
#   Created: Feb 2024
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································
# Pendente:
#   Probar con glm
#   Revisar https://easystats.github.io/insight/

#····································································
# scaled.coef(object, ...) ----
#····································································
#' Scaled (standardized) coefficients
#'
#' Computes the standardized (regression) coefficients, also called beta
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
#' [`QuantPsyc::lm.beta`](https://rdrr.io/cran/QuantPsyc/man/lm.beta.html).
#' @param object an object for which the extraction of model coefficients is
#' meaningful.
#' @param ... further arguments passed to or from other methods.
#' @return A named vector with the scaled coefficients.
#' @seealso [coef()]
#' @export
scaled.coef <- function(object, ...){
  UseMethod("scaled.coef")
}


#' @rdname scaled.coef
#' @method scaled.coef default
#' @param scale.response logical indicating if the response variable should be
#' standardized.
#' @param complete for the default (used for lm, etc) and aov methods: logical
#' indicating if the full coefficient vector should be returned also in case of
#' an over-determined system where some coefficients will be set to [NA].
#' @details Based on [`QuantPsyc::lm.beta`](https://rdrr.io/cran/QuantPsyc/man/lm.beta.html).
#' @examples
#' fit <- lm(fidelida ~ velocida + calidadp, hbat)
#' coef(fit)
#' scaled.coef(fit)
#' fit2 <- lm(scale(fidelida) ~ scale(velocida) + scale(calidadp), hbat)
#' coef(fit2)
#' fit3 <- lm(fidelida ~ scale(velocida) + scale(calidadp), hbat)
#' coef(fit3)
#' scaled.coef(fit, scale.response = FALSE)
#' @export
scaled.coef.default <- function(object, scale.response = TRUE, complete = FALSE, ...) {
    # Coeficientes originales
    cf <- object$coefficients
    # Obtener model.frame con respuesta y predictores
    mf <- model.frame(object)
    # Obtener índice de la respuesta
    ires <- attr(attr(mf, "terms"), "response")
    # Respuesta y std.dev. predictores
    y <- mf[[ires]]
    sx <- sapply(mf[-ires], sd)
    # Coeficientes reescalados
    if(scale.response) {
      cf <- cf[-1]
      sy <- sd(y)
    } else {
      cf[1] <- mean(y)
      sx <- c(1, sx)
      sy <- 1
    }
    cf <- cf * sx /  sy
    if (complete)
      cf
    else
      cf[!is.na(cf)]
}


