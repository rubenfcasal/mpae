#····································································
#   accuracy (mpae package)
#····································································
#   Ruben Fernandez-Casal
#   Modified: Feb 2024
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································
# Pendente:
# - Separar o cálculo erros do cálculo de medidas de precisión

#····································································
# accuracy(pred, obs, na.rm, tol) ----
#····································································
#' Accuracy measures
#'
#' Computes accuracy measurements.
#' @param pred a numeric vector with the predicted values.
#' @param obs a numeric vector with the observed values.
#' @param na.rm a logical indicating whether [NA]
#' values should be stripped before the computation proceeds.
#' @param tol divide underflow tolerance.
#' @return Returns a named vector with the following components:
#' \itemize{
#' \item \code{me} mean error
#' \item \code{rmse} root mean squared error
#' \item \code{mae} mean absolute error
#' \item \code{mpe} mean percent error
#' \item \code{mape} mean absolute percent error
#' \item \code{r.squared} pseudo R-squared
#' }
#' @examples
#' set.seed(1)
#' nobs <- nrow(bodyfat)
#' itrain <- sample(nobs, 0.8 * nobs)
#' train <- bodyfat[itrain, ]
#' test <- bodyfat[-itrain, ]
#' fit <- lm(bodyfat ~ abdomen + wrist, data = train)
#' pred <- predict(fit, newdata = test)
#' obs <- test$bodyfat
#' pred.plot(pred, obs)
#' accuracy(pred, obs)
#' @seealso [pred.plot()]
#' @export
accuracy <- function(pred, obs, na.rm = FALSE,
                     tol = sqrt(.Machine$double.eps)) {
  err <- obs - pred     # Errores
  if(na.rm) {
    is.a <- !is.na(err)
    err <- err[is.a]
    obs <- obs[is.a]
  }
  perr <- 100*err/pmax(obs, tol)  # Errores porcentuales
  return(c(
    me = mean(err),           # Error medio
    rmse = sqrt(mean(err^2)), # Raíz del error cuadrático medio
    mae = mean(abs(err)),     # Error absoluto medio
    mpe = mean(perr),         # Error porcentual medio
    mape = mean(abs(perr)),   # Error porcentual absoluto medio
    r.squared = 1 - sum(err^2)/sum((obs - mean(obs))^2) # Pseudo R-cuadrado
  ))
}

