import sys  
from PyQt4.QtCore import *  
from PyQt4.QtGui import *  
class clock (QWidget):  
	def __init__(self):  
		QWidget.__init__(self,windowTitle="python clock")  
		timer = QTimer(self)  
		self.connect(timer, SIGNAL("timeout()"),self,SLOT("update()"))  
		timer.start(1000)  
		self.resize(200,200)  
		pass  
	def paintEvent(self,e):  
		hourColorHand = QPolygon([QPoint(7,8),QPoint(-7,8),QPoint(0,-30)])  
		minuteColorHand = QPolygon([QPoint(7,8),QPoint(-7,8),QPoint(0,-70)])  
		secondColorHand = QPolygon([QPoint(3,8),QPoint(-3,8),QPoint(0,-90)])  
		hourColor = QColor(127,0,127)  
		minuteColor = QColor(0,127,127,191)  
		secondColor = QColor(0,100,100,100)  
		painter = QPainter(self);  
		side = min(self.width(),self.height())  
		atime =QTime.currentTime()  
		painter.setRenderHint(QPainter.Antialiasing)  
		painter.translate(self.width()/2,self.height()/2)  
		painter.scale(side/200,side/200)  
		painter.setPen(Qt.NoPen)  
		painter.setBrush(hourColor)  
		painter.save()  
		painter.rotate(30.0*(atime.hour() + atime.minute()/60.0))  
		painter.drawConvexPolygon(hourColorHand)  
		painter.restore()  
		painter.setPen(hourColor)  
		for i in range(0,12):  
			painter.drawLine(88,0,96,0)  
			painter.rotate(30.0)  
		painter.setPen(Qt.NoPen)  
		painter.setBrush(minuteColor)  
		painter.save()  
		painter.rotate(6.0*(atime.minute()+atime.second()/60.0))  
		painter.drawConvexPolygon(minuteColorHand)  
		painter.restore()  
		painter.setPen(minuteColor)  
		for i in range(0,60) :  
			if (i%5)!=0 :  
				painter.drawLine(92,0,96,0)  
			painter.rotate(6.0)  
		painter.setPen(Qt.NoPen)  
		painter.setBrush(secondColor)  
		painter.save()  
		painter.rotate(6.0 * atime.second())  
		painter.drawConvexPolygon(secondColorHand)  
		painter.restore()  
		pass  


if __name__ == "__main__" :  
	q = QApplication(sys.argv)  
	s = clock()  
	s.show()  
	q.exec_()