import cv2
import matplotlib as mpl
import numpy as np

img=cv2.imread('Large.jpg')
macula=cv2.imread('temp_macula.jpg',cv2.IMREAD_GRAYSCALE)
disk=cv2.imread('temp_disk.jpg',cv2.IMREAD_GRAYSCALE)
sh=macula.shape
_,macula=cv2.threshold(macula,128,255,cv2.THRESH_BINARY)
_,disk=cv2.threshold(disk,128,255,cv2.THRESH_BINARY)
strel= cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(5,5))
#dis=cv2.morphologyEx(disk,cv2.MORPH_OPEN,strel)
_,contours,_=cv2.findContours(disk,cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_NONE)
#cv2.drawContours(img,countours,-1,(0,0,0))
cont=contours[0]
for cnt in contours:
	if cv2.contourArea(cnt)>cv2.contourArea(cont):
		cont=cnt

ellipse=cv2.minEnclosingCircle(cont)
centre=(np.round(ellipse[0][0]).astype(int), np.round(ellipse[0][1]).astype(int))
radius=np.round(ellipse[1]).astype(int)
cv2.circle(img,centre,radius,(0,0,0))
cv2.imshow('Image',img)
# cv2.imshow('Disk',disk)
# cv2.imshow('Morph Disk',dis)

while(cv2.waitKey(0)!=27):
	pass
cv2.destroyAllWindows()
