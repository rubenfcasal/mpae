#····································································
#   mpae-package.R
#····································································
#   https://github.com/rubenfcasal/mpae
#
#   NOTE: Press Ctrl + Shift + O to show document outline in RStudio
#····································································
# pkgdown::build_site()

#····································································
# mpae-package ----
#····································································
#' mpae: Métodos predictivos de aprendizaje estadístico
#' (statistical learning predictive methods)
#'
#' Functions and datasets used in the book [*Métodos predictivos de
#' aprendizaje estadístico*](https://rubenfcasal.github.io/aprendizaje_estadistico).
#'
#' For more information visit <https://rubenfcasal.github.io/mpae.html>.
#' @keywords simulation bootstrap Monte-Carlo
#' @name mpae-package
#' @aliases mpae
#' @docType package
#' @import graphics
#' @import stats
#' @importFrom caret confusionMatrix
# @importFrom grDevices dev.interactive devAskNewPage dev.flush dev.hold
#' @references
#' Fernández-Casal R., Costa J. y Oviedo M. (2024). *[Métodos predictivos de aprendizaje estadístico](https://rubenfcasal.github.io/aprendizaje_estadistico)*
#' ([github](https://github.com/rubenfcasal/aprendizaje_estadistico)).
#'
#' Fernández-Casal R., Roca-Pardiñas J., Costa J. y Oviedo-de la Fuente M. (2022).
#' *[Introducción al Análisis de Datos con R](https://rubenfcasal.github.io/intror)*
#' ([github](https://github.com/rubenfcasal/intror)).
#'
#' Fernández-Casal R., Cao R., Costa J. (2023).
#' *[Técnicas de Simulación y Remuestreo](https://rubenfcasal.github.io/simbook)*,
#' segunda edición, ([github](https://github.com/rubenfcasal/simbook)).
#'
NULL


#····································································
# winequality ----
#····································································
#' Wine Quality
#'
#' A subset related to the white variant of the Portuguese "Vinho Verde" wine,
#' containing physicochemical information (`fixed.acidity`, `volatile.acidity`,
#' `citric.acid`, `residual.sugar`, `chlorides`, `free.sulfur.dioxide`,
#' `total.sulfur.dioxide` , `density`, `pH`, `sulphates` and `alcohol`)
#' and sensory (`quality`).
#'
#' For more details, consult \url{http://www.vinhoverde.pt/en/} or the reference
#' Cortez et al. (2009).
#'
#' @name winequality
#' @format
#' A data frame with 1,250 rows and 12 columns:
#' \describe{
#'   \item{fixed.acidity}{fixed acidity}
#'   \item{volatile.acidity}{volatile acidity}
#'   \item{citric.acid}{citric acid}
#'   \item{residual.sugar}{residual sugar}
#'   \item{chlorides}{chlorides}
#'   \item{free.sulfur.dioxide}{free sulfur dioxide}
#'   \item{total.sulfur.dioxide}{total sulfur dioxide}
#'   \item{density}{density}
#'   \item{pH}{pH}
#'   \item{sulphates}{sulphates}
#'   \item{alcohol}{alcohol}
#'   \item{quality}{median of at least 3 evaluations of wine quality carried out
#'   by experts, who evaluated them between 0 (very bad) and 10 (very excellent)}
#' }
#' @source UCI Machine Learning Repository: \url{http://archive.ics.uci.edu/dataset/186/wine+quality}.
#' @references
#' Cortez, P., Cerdeira, A., Almeida, F., Matos, T., & Reis, J. (2009).
#' Modeling wine preferences by data mining from physicochemical properties.
#' *Decision Support Systems*, 47(4), 547-553.
#' @keywords datasets
#' @seealso [winetaste()]
#' @examples
#' str(winequality)
NULL



#····································································
# winetaste ----
#····································································
#' Wine Taste
#'
#' A subset related to the white variant of the Portuguese "Vinho Verde" wine,
#' containing physicochemical information (`fixed.acidity`, `volatile.acidity`,
#' `citric.acid`, `residual.sugar`, `chlorides`, `free.sulfur.dioxide`,
#' `total.sulfur.dioxide` , `density`, `pH`, `sulphates` and `alcohol`)
#' and sensory (`taste`), which indicates the quality of the wine (it is
#' considered good if the median of the wine quality evaluations, made by experts,
#' who evaluated them between 0 = very bad and 10 = very excellent, is not less
#' than 6.
#'
#' For more details, consult \url{http://www.vinhoverde.pt/en/} or the reference
#' Cortez et al. (2009).
#'
#' @name winetaste
#' @format
#' A data frame with 1,250 rows and 12 columns:
#' \describe{
#'   \item{fixed.acidity}{fixed acidity}
#'   \item{volatile.acidity}{volatile acidity}
#'   \item{citric.acid}{citric acid}
#'   \item{residual.sugar}{residual sugar}
#'   \item{chlorides}{chlorides}
#'   \item{free.sulfur.dioxide}{free sulfur dioxide}
#'   \item{total.sulfur.dioxide}{total sulfur dioxide}
#'   \item{density}{density}
#'   \item{pH}{pH}
#'   \item{sulphates}{sulphates}
#'   \item{alcohol}{alcohol}
#'   \item{taste}{factor with levels `"good"` and `"bad"` indicating the quality
#'   of the wine}
#' }
#' @source UCI Machine Learning Repository: \url{http://archive.ics.uci.edu/dataset/186/wine+quality}.
#' @references
#' Cortez, P., Cerdeira, A., Almeida, F., Matos, T., & Reis, J. (2009).
#' Modeling wine preferences by data mining from physicochemical properties.
#' *Decision Support Systems*, 47(4), 547-553.
#' @keywords datasets
#' @seealso [winequality()]
#' @examples
#' winetaste <- winequality[, names(winequality)!="quality"]
#' winetaste$taste <- factor(winequality$quality < 6,
#'                       labels = c('good', 'bad')) # levels = c('FALSE', 'TRUE')
#' str(winetaste)
NULL



#····································································
# hbat ----
#····································································
#' HBAT data
#'
#' A dataset containing observations of customers of the industrial
#' distribution company HBAT.
#' The variables can be classified into three groups:
#' the first 6 (categorical) are shopper characteristics (data warehouse
#' classification), variables 7 to 19 (numerical) measure shopper perceptions
#' of HBAT and the last 5 are possible target variables (responses),
#' the purchase outcomes.
#'
#' For more details, consult the reference
#' Hair et al. (1998).
#'
#' @name hbat
#' @format
#' A data frame with 200 rows and 24 columns:
#' \describe{
#'   \item{empresa}{Customer ID.}
#'   \item{tcliente}{Customer Type. Length of time a particular customer has been
#'   buying from HBAT: \code{Menos de 1 año} = less than 1 year. \code{De 1 a 5 años} = between 1 and 5 years.
#'   \code{Más de 5 años} = longer than 5 years.}
#'   \item{tindustr }{Type of industry that purchases HBAT’s paper products:
#'   \code{Revista} = magazine industry, \code{Periodico} = newsprint industry.}
#'   \item{tamaño}{Employee size:
#'   \code{Pequeña (<500)} = small firm, fewer than 500 employees,
#'   \code{Grande (>=500)} = large firm, 500 or more employees.}
#   \code{Pequeña} = small firm, fewer than 500 employees,
#   \code{Grande} = large firm, 500 or more employees.}
#'   \item{region}{Customer location:
#'   \code{America del norte} = USA/North America, \code{Otros} = outside North America.}
#'   \item{distrib}{Distribution System. How paper products are sold to customers:
#'   \code{Indirecta} = sold indirectly through a broker, \code{Directa} = sold directly.}
#'   \item{calidadp}{Product Quality. Perceived level of quality of HBAT’s paper
#'   products.}
#'   \item{web}{E-Commerce Activities/Web Site. Overall image of HBAT’s Web site,
#'   especially user-friendliness.}
#'   \item{soporte}{Technical Support. Extent to which technical support is offered
#'   to help solve product/service issues.}
#'   \item{quejas}{Complaint Resolution. Extent to which any complaints are
#'   resolved in a timely and complete manner.}
#'   \item{publi}{Advertising. Perceptions of HBAT’s advertising campaigns in all
#'   types of media.}
#'   \item{producto}{Product Line. Depth and breadth of HBAT’s product line to meet
#'   customer needs.}
#'   \item{imgfvent}{Salesforce Image. Overall image of HBAT’s salesforce.}
#'   \item{precio}{Competitive Pricing. Extent to which HBAT offers competitive
#'   prices.}
#'   \item{garantia}{Warranty and Claims. Extent to which HBAT stands behind its
#'   product/service warranties and claims.}
#'   \item{nprod}{New Products. Extent to which HBAT develops and sells new
#'   products.}
#'   \item{facturac}{Ordering and Billing. Perception that ordering and billing
#'   is handled efficiently and correctly.}
#'   \item{flexprec}{Price Flexibility. Perceived willingness of HBAT sales reps
#'   to negotiate price on purchases of paper products.}
#'   \item{velocida}{Delivery Speed. Amount of time it takes to deliver the paper
#'   products once an order has been confirmed.}
#'   \item{satisfac}{Customer satisfaction with past purchases from HBAT,
#'   measured on a 10-point graphic rating scale.}
#'   \item{precomen}{Likelihood of recommending HBAT to other firms as a supplier
#'   of paper products, measured on a 10-point graphic rating scale.}
#'   \item{pcompra}{Likelihood of purchasing paper products from HBAT in the
#'   future, measured on a 10-point graphic rating scale.}
#'   \item{fidelida}{Percentage of Purchases from HBAT. Percentage of the
#'   responding firm’s paper needs purchased from HBAT, measured on a 100-point
#'   percentage scale.}
#'   \item{alianza}{Perception of Future Relationship with HBAT. Extent to which
#'   the customer/respondent perceives his or her firm would engage in strategic
#'   alliance/partnership with HBAT:
#'   \code{No} = Would not consider. \code{Si} = Yes, would consider strategic alliance or partnership.}
#' }
#' @source Hair et al. (1998).
#' @references
#' Hair, J. F., Anderson, R. E., Tatham, R. L., y Black, W. (1998).
#' *Multivariate Data Analysis*. Prentice Hall.
#' @keywords datasets
#' @examples
#' str(hbat)
#' as.data.frame(attr(hbat, "variable.labels"))
#' summary(hbat)
NULL


#····································································
.onAttach <- function(libname, pkgname){
#····································································
  #   pkg.info <- utils::packageDescription(pkgname, libname, fields = c("Title", "Version", "Date"))
  pkg.info <- drop( read.dcf( file = system.file("DESCRIPTION", package = "mpae"),
                              fields = c("Title", "Version", "Date") ))
  packageStartupMessage(
    paste0(" mpae: ", pkg.info["Title"], ",\n"),
    paste0(" version ", pkg.info["Version"], " (built on ", pkg.info["Date"], ").\n"),
    " Type `help(mpae)` for an overview of the package or\n",
    " visit https://rubenfcasal.github.io/mpae.\n")
}
