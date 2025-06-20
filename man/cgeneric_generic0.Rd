% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cgeneric_generic0.R
\name{cgeneric_generic0}
\alias{cgeneric_generic0}
\title{Build an \code{cgeneric} object for a \code{generic0} model.
See details.}
\usage{
cgeneric_generic0(
  R,
  param,
  constr = TRUE,
  scale = TRUE,
  debug = FALSE,
  useINLAprecomp = TRUE,
  libpath = NULL
)
}
\arguments{
\item{R}{the structure matrix for the model definition.}

\item{param}{length two vector with the parameters
\code{a} and \code{p} for the PC-prior distribution defined from
\deqn{P(\sigma > a) = p}
where \eqn{\sigma} can be interpreted as marginal standard
deviation of the process if scale = TRUE. See details.}

\item{constr}{logical indicating if it is to add a
sum-to-zero constraint. Default is TRUE.}

\item{scale}{logical indicating if it is to scale
the model. See detais.}

\item{debug}{integer, default is zero, indicating the verbose level.
Will be used as logical by INLA.}

\item{useINLAprecomp}{logical, default is TRUE, indicating if it is to
be used the shared object pre-compiled by INLA.
This is not considered if 'libpath' is provided.}

\item{libpath}{string, default is NULL, with the path to the shared object.}
}
\value{
a \code{cgeneric} object, see \code{\link[=cgeneric]{cgeneric()}}.
}
\description{
Build data needed to implement a model whose
precision has a conditional precision parameter.
This uses the C interface in the 'INLA' package,
that can be used as a linear predictor
model component with an 'f' term.
}
\details{
The precision matrix is defined as
\deqn{Q = \tau R}
where the structure matrix R is supplied by the user
and \eqn{\tau} is the precision parameter.
Following Sørbie and Rue (2014), if scale = TRUE
the model is scaled so that
\deqn{Q = \tau s R}
where \eqn{s} is the geometric mean of the diagonal
elements of the generalized inverse of \eqn{R}.
\deqn{s = \exp{\sum_i \log((R^{-})_{ii})/n}}
If the model is scaled, the geometric mean of the
marginal variances, the diagonal of \eqn{Q^{-1}}, is one.
Therefore, when the model is scaled,
\eqn{\tau} is the marginal precision,
otherwise \eqn{\tau} is the conditional precision.
}
\examples{
## structured precision matrix model definition
R <- Matrix(toeplitz(c(2,-1,0,0,0)))
mR <- cgeneric("generic0", R = R,
  scale = FALSE, param = c(1, 0.05),
  useINLAprecomp = FALSE)
graph(mR)
prec(mR, theta = 0)
}
\references{
Sigrunn Holbek Sørbye and Håvard Rue (2014).
Scaling intrinsic Gaussian Markov random field priors in
spatial modelling. Spatial Statistics, vol. 8, p. 39-51.
}
\seealso{
\code{\link[=prior.cgeneric]{prior.cgeneric()}}
}
