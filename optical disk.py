import cv2
import numpy as np

imrgb = cv2.imread('Large.jpg')
imluv = cv2.cvtColor(imrgb,cv2.COLOR_BGR2Luv)

cv2.imshow('Converted',imluv)

while cv2.waitKey(0) != 27:
	pass

cv2.destroyAllWindows()