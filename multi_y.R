## Multiple response models

earth(cbind(O3,wind) ~., data = ozone1)
earth(ozone1[,-c(1,3)], ozone1[,c(1,3)])
earth(cbind(log.O3=log(O3), wind) ~ ., data = ozone1)
earth(x=data.frame(x1, x2, log.x3=log(x3)), y=data.frame(y1, y2))