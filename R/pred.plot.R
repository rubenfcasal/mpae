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
#' Observed vs. predicted plots
#'
#' Generates plots comparing predictions with observations.
#' @inheritParams accuracy
#' @param ... additional graphical parameters (e.g. to be passed to
#' [RcmdrMisc::Barplot()]).
#' @examples
#' set.seed(1)
#' nobs <- nrow(hbat)
#' itrain <- sample(nobs, 0.8 * nobs)
#' train <- hbat[itrain, ]
#' test <- hbat[-itrain, ]
#'
#' # Regression
#' fit <- lm(fidelida ~ velocida + calidadp, data = train)
#' pred <- predict(fit, newdata = test)
#' obs <- test$fidelida
#' res <- pred.plot(pred, obs)
#' summary(res)
#'
#' # Classification
#' fit2 <- glm(alianza ~ velocida + calidadp, family = binomial, data = train)
#' obs <- test$alianza
#' p.est <- predict(fit2, type = "response", newdata = test)
#' pred <- factor(p.est > 0.5, labels = levels(obs))
#' pred.plot(pred, obs, type = "frec", style = "parallel")
#' old.par <- par(mfrow = c(1, 2))
#' pred.plot(pred, obs, type = c("perc", "cperc"))
#' par(old.par)
#' @export
pred.plot <- function(pred, obs, ...){
  UseMethod("pred.plot")
}

#' @rdname pred.plot
#' @method pred.plot default
#' @details
#' The default method draws a scatter plot of the observed values against the
#' predicted values.
#' @param xlab a title for the x axis.
#' @param ylab a title for the y axis.
#' @param lm.fit logical indicating if a \code{\link[stats]{lm}} fit is
#' added to the plot.
#' @param lowess logical indicating if a \code{\link[stats]{lowess}} smooth is
#' added to the plot.
#' @returns
#' The default method invisibly returns the fitted linear model if
#' \code{lm.fit == TRUE}.
#' @export
#····································································
pred.plot.default <- function(pred, obs, xlab = "Predicted", ylab = "Observed",
                              lm.fit = TRUE, lowess = TRUE, ...){
#····································································
  stopifnot(is.numeric(pred), is.numeric(obs))
  plot(pred, obs, xlab = xlab, ylab = ylab, ...)
  abline(a = 0, b = 1, lwd = 2)
  if (lowess)
    lines(lowess(pred, obs), lty = 2, lwd = 2, col = 'blue')
  if (lm.fit) {
    res <- lm(obs ~ pred)
    # summary(res)
    abline(res, lty = 2)
    return(invisible(res))
  }
}

#' @rdname pred.plot
#' @method pred.plot factor
#' @details
#' `pred.plot.factor()` creates bar plots representing frequencies, percentages
#' or conditional percentages of `pred` within levels of `obs`.
#' This method is a front end to [RcmdrMisc::Barplot()].
#' @param type types of the desired plots. Any combination of the following
#' values is possible: `"frec"` for frequencies, `"perc"` for percentages or
#' `"cperc"` for conditional percentages.
#' @param legend.title a title for the legend.
#' @param label.bars if `TRUE` (the default) show values of frequencies or
#' percents in the bars.
#' @returns
#' `pred.plot.factor()` invisibly returns the horizontal coordinates of the
#' centers of the bars.
#' @export
#····································································
pred.plot.factor <- function(pred, obs, type = c("frec", "perc", "cperc"),
    xlab = "Observed", ylab = NULL, legend.title = "Predicted",
    label.bars = TRUE, ...){
#····································································
# https://rdrr.io/cran/RcmdrMisc/man/Barplot.html
  if (!is.factor(obs) | any(levels(obs) != levels(pred)))
    stop("`obs` must be a factor with the same levels as `pred`.", call. = FALSE)
  type <- match.arg(type, several.ok = TRUE)
  no.ylab <- missing(ylab)
  if ("frec" %in% type) {
    if (no.ylab) ylab <- "Frequency"
    RcmdrMisc::Barplot(obs, by = pred, xlab = xlab, ylab = ylab,
                       legend.title = legend.title, label.bars = label.bars, ...)
  }
  if ("perc" %in% type) {
    if (no.ylab) ylab <- "Percentage"
    RcmdrMisc::Barplot(obs, by = pred, scale = "percent", conditional = FALSE,
                       xlab = xlab, ylab = ylab, legend.title = legend.title,
                       label.bars = label.bars, ...)
  }
  if ("cperc" %in% type) {
    if (no.ylab) ylab <- "Conditional percentage"
    RcmdrMisc::Barplot(obs, by = pred, scale = "percent", xlab = xlab, ylab = ylab,
                       legend.title = legend.title, label.bars = label.bars, ...)
  }
}

