#····································································
#   accuracy (mpae package)
#····································································
#   Ruben Fernandez-Casal
#   Modified: Feb 2024
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································

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


#····································································
# obs.pred.plot(pred, obs, xlab, ylab, lm.fit, lowess, ...) ----
#····································································
#' Observed vs. predicted plot
#'
#' Draws a scatter plot of the observed values against the predicted values.
#' @inheritParams accuracy
#' @param xlab a title for the axis corresponding to the predicted values.
#' @param ylab a title for the axis corresponding to the observed values.
#' @param lm.fit logical indicating if a \code{\link[stats]{lm}} fit is
#' added to the plot.
#' @param lowess logical indicating if a \code{\link[stats]{lowess}} smooth is
#' added to the plot.
#' @param ... additional graphical parameters.
#' @return Invisibly returns the fitted linear model if \code{lm.fit == TRUE}.
#' @examples
#' set.seed(1)
#' nobs <- nrow(hbat)
#' itrain <- sample(nobs, 0.8 * nobs)
#' train <- hbat[itrain, ]
#' test <- hbat[-itrain, ]
#' fit <- lm(fidelida ~ velocida + calidadp, train)
#' pred <- predict(fit, newdata = test)
#' obs <- test$fidelida
#' res <- obs.pred.plot(pred, obs)
#' summary(res)
#' @export
obs.pred.plot <- function(pred, obs, xlab = "Predicted", ylab = "Observed",
                          lm.fit = TRUE, lowess = TRUE, ...){
  plot(pred, obs, xlab = xlab, ylab = ylab, ...)
  abline(a = 0, b = 1, lwd = 2)
  if (lowess)
    lines(lowess(pred, obs), lty = 2, lwd = 2, col = 'blue')
  if (lm.fit){
    res <- lm(obs ~ pred)
    # summary(res)
    abline(res, lty = 2)
    return(invisible(res))
  }
}


# print.confusionMatrix <- function (x, mode = x$mode,
#     digits = max(3, getOption("digits") - 3), printStats = TRUE, ...) {
#     if (is.null(mode))
#         mode <- "sens_spec"
#     if (!(mode %in% c("sens_spec", "prec_recall", "everything")))
#         stop("`mode` should be either 'sens_spec', 'prec_recall', or 'everything'")
#     cat("Confusion Matrix and Statistics\n\n")
#     print(t(x$table), ...)
#     if (printStats) {
#         tmp <- round(x$overall, digits = digits)
#         pIndex <- grep("PValue", names(x$overall))
#         tmp[pIndex] <- format.pval(x$overall[pIndex], digits = digits)
#         overall <- tmp
#         accCI <- paste("(", paste(overall[c("AccuracyLower",
#             "AccuracyUpper")], collapse = ", "), ")", sep = "")
#         overallText <- c(paste(overall["Accuracy"]), accCI, paste(overall[c("AccuracyNull",
#             "AccuracyPValue")]), "", paste(overall["Kappa"]),
#             "", paste(overall["McnemarPValue"]))
#         overallNames <- c("Accuracy", "95% CI", "No Information Rate",
#             "P-Value [Acc > NIR]", "", "Kappa", "", "Mcnemar's Test P-Value")
#         if (dim(x$table)[1] > 2) {
#             cat("\nOverall Statistics\n")
#             overallNames <- ifelse(overallNames == "", "", paste(overallNames,
#                 ":"))
#             out <- cbind(format(overallNames, justify = "right"),
#                 overallText)
#             colnames(out) <- rep("", ncol(out))
#             rownames(out) <- rep("", nrow(out))
#             print(out, quote = FALSE)
#             cat("\nStatistics by Class:\n\n")
#             if (mode == "prec_recall")
#                 x$byClass <- x$byClass[, !grepl("(Sensitivity)|(Specificity)|(Pos Pred Value)|(Neg Pred Value)",
#                   colnames(x$byClass))]
#             if (mode == "sens_spec")
#                 x$byClass <- x$byClass[, !grepl("(Precision)|(Recall)|(F1)",
#                   colnames(x$byClass))]
#             print(t(x$byClass), digits = digits)
#         }
#         else {
#             if (mode == "prec_recall")
#                 x$byClass <- x$byClass[!grepl("(Sensitivity)|(Specificity)|(Pos Pred Value)|(Neg Pred Value)",
#                   names(x$byClass))]
#             if (mode == "sens_spec")
#                 x$byClass <- x$byClass[!grepl("(Precision)|(Recall)|(F1)",
#                   names(x$byClass))]
#             overallText <- c(overallText, "", format(x$byClass,
#                 digits = digits))
#             overallNames <- c(overallNames, "", names(x$byClass))
#             overallNames <- ifelse(overallNames == "", "", paste(overallNames,
#                 ":"))
#             overallNames <- c(overallNames, "", "'Positive' Class :")
#             overallText <- c(overallText, "", x$positive)
#             out <- cbind(format(overallNames, justify = "right"),
#                 overallText)
#             colnames(out) <- rep("", ncol(out))
#             rownames(out) <- rep("", nrow(out))
#             out <- rbind(out, rep("", 2))
#             print(out, quote = FALSE)
#         }
#     }
#     invisible(x)
# }

