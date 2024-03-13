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
#' Fernández-Casal R., Cao R. y Costa J. (2023).
#' *[Técnicas de Simulación y Remuestreo](https://rubenfcasal.github.io/simbook)*,
#' segunda edición, ([github](https://github.com/rubenfcasal/simbook)).
NULL # mpae-package


#····································································
# bodyfat.raw ----
#····································································
#' Original body fat data
#'
#' Popular dataset originally analysed in Penrose et al. (1985).
#' Lists estimates of the percentage of body fat determined by underwater weighing
#' and various body measurements for 252 men.
#'
#' This data set can be used to illustrate data cleaning and multiple regression
#' techniques (e.g. Johnson 1996).
#' Percentage of body fat for an individual can be estimated from body density,
#' for instance by using Siri's (1956) equation:
#' \deqn{bodyfat = 495/density - 450.}
#' Volume, and hence body density, can be accurately measured by underwater
#' weighing (e.g. Katch and McArdle, 1977).
#' However, this procedure for the accurate measurement of body fat is
#' inconvenient and costly.
#' It is desirable to have easy methods of estimating body fat from body
#' measurements.
#'
#' "Measurement standards are apparently those listed in Benhke and Wilmore
#' (1974), pp. 45-48 where, for instance, the abdomen 2 circumference is
#' measured 'laterally, at the level of the iliac crests, and anteriorly, at
#' the umbilicus'.
#'
#' Johnson (1996) uses the original data in an activity to introduce students
#' to data cleaning before performing multiple linear regression.
#' An examination of the data reveals some unusual cases:
#'
#' * Cases 48, 76, and 96 seem to have a one-digit error in the listed density values.
#'
#' * Case 42 appears to have a one-digit error in the height value.
#'
#' * Case 182 appears to have an error in the density value (as it is greater
#' than 1.1, the density of the "fat free mass"; resulting in a negative estimate
#' of body fat percentage that was truncated to zero).
#'
#' Johnson (1996) suggests some rules for correcting these values
#' (see examples below).
#'
#' @name bodyfat.raw
#' @format
#' A data frame with 252 rows and 15 columns:
#' \describe{
#'   \item{density}{Density (gm/cm^3; determined from underwater weighing)}
#'   \item{bodyfat}{Percent body fat (from Siri's 1956 equation)}
#'   \item{age}{Age (years)}
#'   \item{weight}{Weight (lbs)}
#'   \item{height}{Height (inches)}
#'   \item{neck}{Neck circumference (cm)}
#'   \item{chest}{Chest circumference (cm)}
#'   \item{abdomen}{Abdomen 2 circumference (cm)}
#'   \item{hip}{Hip circumference (cm)}
#'   \item{thigh}{Thigh circumference (cm)}
#'   \item{knee}{Knee circumference (cm)}
#'   \item{ankle}{Ankle circumference (cm)}
#'   \item{biceps}{Biceps (extended) circumference (cm)}
#'   \item{forearm}{Forearm circumference (cm)}
#'   \item{wrist}{Wrist circumference (cm)}
#' }
#' @source
#' StatLib Datasets Archive: \url{http://lib.stat.cmu.edu/datasets/bodyfat}.
#' @references
#' Johnson, R. W. (1996). Fitting Percentage of Body Fat to Simple Body
#' Measurements. *Journal of Statistics Education*, 4(1).
#' \url{https://doi.org/10.1080/10691898.1996.11910505}.
#'
#' Penrose, K., Nelson, A. and Fisher, A. (1985). Generalized Body Composition
#' Prediction Equation for Men Using Simple Measurement Techniques.
#' *Medicine and Science in Sports and Exercise*, 17(2), 189.
#' \url{https://doi.org/10.1249/00005768-198504000-00037}.
#'
#' Siri, W. E. (1956). Gross Composition of the Body, in *Advances in Biological
#' and Medical Physics* (Vol. IV), eds. J. H. Lawrence and C. A. Tobias,
#' Academic Press.
#' @keywords datasets
#' @seealso [`bodyfat`], [`bfan`]
#' @examples
#' bodyfat <- bodyfat.raw
#' # Johnson's (1996) corrections
#' cases <- c(48, 76, 96) # bodyfat != 495/density - 450
#' bodyfat$density[cases] <- 495 / (bodyfat$bodyfat[cases] + 450)
#' bodyfat$height[42] <- 69.5
#' # Other possible data entry errors
#' # See https://stat-ata-asu.github.io/PredictiveModelBuilding/BFdata.html
#' bodyfat$ankle[31] <- 23.9
#' bodyfat$ankle[86] <- 23.7
#' bodyfat$forearm[159] <- 24.9
#' # Outlier and influential observation
#' outliers <- c(182, 39)
#' bodyfat[outliers, ]
#' bodyfat <- bodyfat[-outliers, ]
#'
#' # Body mass index (kg/m2)
#' bodyfat$bmi <- with(bodyfat, weight/(height*0.0254)^2)
#' # Alternate body mass index
#' bodyfat$bmi2 <- with(bodyfat, (weight*0.45359237)^1.2/(height*0.0254)^3.3)
#' # See e.g. https://en.wikipedia.org/wiki/Body_fat_percentage#From_BMI
#' # \text{(Adult) body fat percentage} = (1.39 \times \text{BMI})
#' #               + (0.16 \times \text{age}) - (10.34 \times \text{gender}) - 9
"bodyfat.raw"


#····································································
# bodyfat ----
#····································································
#' Body fat data
#'
#' Modification of the dataset analysed in Penrose et al. (1985).
#' Lists estimates of the percentage of body fat determined by underwater weighing
#' and various body measurements for 246 men.
#'
#' This data set can be used to illustrate multiple regression techniques
#' (e.g. Johnson 1996).
#' Instead of estimating body fat percentage from body density, which is not
#' easy to measure, it is desirable to have a simpler method that allow this to
#' be done from body measurements.
#'
#' [`bodyfat.raw`] contains the original data.
#' According to Johnson (1996), there were data entry errors (cases 42, 48, 76,
#' 96 and 182 of the original data) and he suggested some rules to correct them.
#' These outliers were removed in the `bodyfat` dataset, as well as an influential
#' observation (case 39, which has a big effect on regression estimates).
#' Additionally, the variable `density` was dropped for convenience, and variables
#' `height` and `weight` were transformed into metric units (centimetres and
#' kilograms) for consistency.
#'
#' See [`bodyfat.raw`] for more details.
#'
#' @name bodyfat
#' @format
#' A data frame with 246 rows and 14 columns:
#' \describe{
#'   \item{bodyfat}{Percent body fat (from Siri's 1956 equation)}
#'   \item{age}{Age (years)}
#'   \item{weight}{Weight (kg)}
#'   \item{height}{Height (cm)}
#'   \item{neck}{Neck circumference (cm)}
#'   \item{chest}{Chest circumference (cm)}
#'   \item{abdomen}{Abdomen circumference (cm)}
#'   \item{hip}{Hip circumference (cm)}
#'   \item{thigh}{Thigh circumference (cm)}
#'   \item{knee}{Knee circumference (cm)}
#'   \item{ankle}{Ankle circumference (cm)}
#'   \item{biceps}{Biceps (extended) circumference (cm)}
#'   \item{forearm}{Forearm circumference (cm)}
#'   \item{wrist}{Wrist circumference (cm)}
#' }
#' @source
#' StatLib Datasets Archive: \url{http://lib.stat.cmu.edu/datasets/bodyfat}.
#' @references
#' Johnson, R. W. (1996). Fitting Percentage of Body Fat to Simple Body
#' Measurements. *Journal of Statistics Education*, 4(1).
#' \url{https://doi.org/10.1080/10691898.1996.11910505}.
#'
#' Penrose, K., Nelson, A. and Fisher, A. (1985). Generalized Body Composition
#' Prediction Equation for Men Using Simple Measurement Techniques.
#' *Medicine and Science in Sports and Exercise*, 17(2), 189.
#' \url{https://doi.org/10.1249/00005768-198504000-00037}.
#' @keywords datasets
#' @seealso [`bodyfat.raw`], [`bfan`]
#' @examples
#' fit <- lm(bodyfat ~ abdomen, bodyfat)
#' summary(fit)
#' plot(bodyfat ~ abdomen, bodyfat)
#' abline(fit)
"bodyfat"


#····································································
# bfan ----
#····································································
#' Above normal body fat data
#'
#' Modification of the [`bodyfat`] dataset for classification.
#' The response `bfan` is a factor indicating a body fat value above the normal
#' range.
#' The variable `bodyfat` was dropped for convenience, and two new variables
#' `bmi` (body mass index, in kg/m^2) and `bmi2` (alternate body mass index,
#' in kg^1.2/m^3.3) were computed (see examples below).
#'
#' See [`bodyfat`] and [`bodyfat.raw`] for details.
#'
#' @name bfan
#' @format
#' A data frame with 246 rows and 16 columns:
#' \describe{
#'   \item{bfan}{Body fat above normal range}
#'   \item{age}{Age (years)}
#'   \item{weight}{Weight (kg)}
#'   \item{height}{Height (cm)}
#'   \item{neck}{Neck circumference (cm)}
#'   \item{chest}{Chest circumference (cm)}
#'   \item{abdomen}{Abdomen circumference (cm)}
#'   \item{hip}{Hip circumference (cm)}
#'   \item{thigh}{Thigh circumference (cm)}
#'   \item{knee}{Knee circumference (cm)}
#'   \item{ankle}{Ankle circumference (cm)}
#'   \item{biceps}{Biceps (extended) circumference (cm)}
#'   \item{forearm}{Forearm circumference (cm)}
#'   \item{wrist}{Wrist circumference (cm)}
#'   \item{bmi}{Body mass index (kg/m2)}
#'   \item{bmi2}{Alternate body mass index}
#' }
#' @source
#' StatLib Datasets Archive: \url{http://lib.stat.cmu.edu/datasets/bodyfat}.
#' @references
#' Penrose, K., Nelson, A. and Fisher, A. (1985). Generalized Body Composition
#' Prediction Equation for Men Using Simple Measurement Techniques.
#' *Medicine and Science in Sports and Exercise*, 17(2), 189.
#' \url{https://doi.org/10.1249/00005768-198504000-00037}.
#' @keywords datasets
#' @seealso [`bodyfat`], [`bodyfat.raw`]
#' @examples
#' bfan <- bodyfat
#' # Body fat above normal
#' bfan[1] <- factor(bfan$bodyfat > 24 , # levels = c('FALSE', 'TRUE'),
#'                 labels = c('No', 'Yes'))
#' names(bfan)[1] <- "bfan"
#' bfan$bmi <- with(bfan, weight/(height/100)^2)
#' bfan$bmi2 <- with(bfan, weight^1.2/(height/100)^3.3)
#'
#' fit <- glm(bfan ~ abdomen, family = binomial, data = bfan)
#' summary(fit)
"bfan"


#····································································
# winequality ----
#····································································
#' Wine quality data
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
#' @seealso [`winetaste`]
#' @examples
#' str(winequality)
"winequality"



#····································································
# winetaste ----
#····································································
#' Wine taste data
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
#' @seealso [`winequality`]
#' @examples
#' winetaste <- winequality[, names(winequality)!="quality"]
#' winetaste$taste <- factor(winequality$quality < 6,
#'                       labels = c('good', 'bad')) # levels = c('FALSE', 'TRUE')
#' str(winetaste)
"winetaste"



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
"hbat"


#····································································
.onAttach <- function(libname, pkgname){
#····································································
  #   pkg.info <- utils::packageDescription(pkgname, libname, fields = c("Title", "Version", "Date"))
  pkg.info <- drop( read.dcf( file = system.file("DESCRIPTION", package = "mpae"),
                              fields = c("Title", "Version", "Date") ))
  packageStartupMessage(
    " mpae: Metodos predictivos de aprendizaje estadistico\n",
    " (statistical learning predictive methods),\n",
    paste0(" version ", pkg.info["Version"], " (built on ", pkg.info["Date"], ").\n"),
    " Type `help(mpae)` for an overview of the package or\n",
    " visit https://rubenfcasal.github.io/mpae.\n")
}
