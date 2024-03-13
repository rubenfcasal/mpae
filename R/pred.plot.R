#····································································
#   pred.plot (mpae package)
#····································································
#   Ruben Fernandez-Casal
#   Modified: Mar 2024
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································
# Pendente:
#   Cambiar exemplo a bodyfat
#   Engadir método factor

#····································································
# pred.plot(pred, obs, ...) ----
#····································································
#' Observed vs. predicted plot
#'
#' Generates a plot comparing predictions with observations.
#' @inheritParams accuracy
#' @param ... additional graphical parameters.
#' @export
pred.plot <- function(pred, obs, ...){
  UseMethod("pred.plot")
}

#' @rdname pred.plot
#' @method pred.plot default
#' @details
#' The default method draws a scatter plot of the observed values against the predicted values.
#' @param xlab a title for the axis corresponding to the predicted values.
#' @param ylab a title for the axis corresponding to the observed values.
#' @param lm.fit logical indicating if a \code{\link[stats]{lm}} fit is
#' added to the plot.
#' @param lowess logical indicating if a \code{\link[stats]{lowess}} smooth is
#' added to the plot.
#' @returns
#' The default method invisibly returns the fitted linear model if \code{lm.fit == TRUE}.
#' @examples
#' set.seed(1)
#' nobs <- nrow(hbat)
#' itrain <- sample(nobs, 0.8 * nobs)
#' train <- hbat[itrain, ]
#' test <- hbat[-itrain, ]
#' fit <- lm(fidelida ~ velocida + calidadp, train)
#' pred <- predict(fit, newdata = test)
#' obs <- test$fidelida
#' res <- pred.plot(pred, obs)
#' summary(res)
#' @export
pred.plot.default <- function(pred, obs, xlab = "Predicted", ylab = "Observed",
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
