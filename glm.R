## ###################
## steps
## ###################

## step 1: builds a standard MARS model
## 	   knot positions and terms are determined as usual and all the standard fields in earth’s return value will be present.

## step 2: invokes glm for the response on bx with the parameters specified in the glm argument to earth.
## notes: For multiple response models (when y has multiple columns), the call to glm is repeated independently for each response.

## ###################
## examples
## ###################

## Two-level factor or logical response

a1 = earth(survived~., data=etitanic, trace = 1, glm = list(family=binomial))
# equivalent but using earth.default
a1a <- earth(x=etitanic[,-2], y=etitanic[,2], trace=1, glm=list(family=binomial))

## factor response (more than two levels)
a2 <- earth(pclass~., data=etitanic, trace=1, glm=list(family=binomial))

## Binomial model specified with a column pair. A single response model (why??)
ldose <- rep(0:5, 2) - 2
sex <- factor(rep(c("male", "female"), times=c(6,6)))
numdead <- c(1,4,9,13,18,20,0,2,6,10,12,16)
pair <- cbind(numdead, numalive=20 - numdead)
a3 <- earth(pair ~ sex + ldose, trace=1, pmethod="none", glm=list(family=binomial(link=probit), maxit=100))


## Double binomial response. A multiple response model (???)

numdead2 <- c(2,8,11,12,20,23,0,4,6,16,12,14) # bogus data
doublepair <- cbind(numdead, numalive=20-numdead,
numdead2=numdead2, numalive2=30-numdead2)
a4 <- earth(doublepair ~ sex + ldose, trace=1, pmethod="none", glm=list(family="binomial"))

## Poisson model.
counts <- c(18,17,15,20,10,20,25,13,12)
outcome <- gl(3,1,9)
treatment <- gl(3,3)
a5 <- earth(counts ~ outcome + treatment, trace=1, pmethod="none", glm=list(family=poisson))

## Standard earth model (equivalent to a standard earth model)

a6 <- earth(numdead ~ sex + ldose, trace=1, pmethod="none",
glm=list(family=gaussian(link=identity)))
print(a6$coefficients == a6$glm.coefficients) # all TRUE

