import 'dart:math';

import 'package:clockfl/utils/colors.dart';
import 'package:flutter/rendering.dart';

class Painter extends CustomPainter {

  DateTime dateTime = DateTime.now();

  double offset = 10;

  @override
  void paint ( Canvas canvas, Size size ) {
      double centerX = size.width   / 2;
      double centerY = size.height  / 2;
      double radius  = min(centerX, centerY);

      Offset center  = Offset(centerX, centerY);

      Paint externOutlineBrush = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = watchColor;
      
      Paint outlineBrush = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = watchColor;

      Paint hourOutlineBrush = Paint()
      ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = hourCircleColor;

      Paint minuteOutlineBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = minuteCircleColor;

      Paint secondOutlineBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = secondsCircleColor;

      Paint centerFillBrush = Paint()
        ..color = centerDotColor;

      Paint secondBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = watchColor;

      Paint minuteBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = watchColor;

      Paint hourBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = watchColor;

      Paint hourTraceBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = watchColor;

      Paint secondTraceBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = watchColor;

      Paint degreeTracesBrush = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5
        ..color = watchColor;

      

      double secondRadius = 4 * radius / 5;
      double minuteRadius = 3 * radius / 5;
      double hourRadius   = 2.5 * radius / 5;

      double secondAngle = dateTime.second * 6 * pi / 180 - pi / 2;
      double minuteAngle = dateTime.minute * 6 * pi / 180 - pi / 2 ;
      double hourAngle = ( dateTime.hour * 30 + dateTime.minute * 0.5 ) * pi / 180 - pi / 2;

      double secondX = centerX + ( secondRadius * cos(secondAngle));
      double secondY = centerY + ( secondRadius * sin(secondAngle));

      double minuteX = centerX + ( minuteRadius * cos(minuteAngle));
      double minuteY = centerY + ( minuteRadius * sin(minuteAngle));

      double hourX   = centerX + ( hourRadius   * cos(hourAngle));
      double hourY   = centerY + ( hourRadius   * sin(hourAngle));

      canvas.drawCircle(center, radius - offset * 2.50, outlineBrush);
      canvas.drawCircle(center, radius - offset * 4.00, externOutlineBrush);

      double hourOffset   = 1.60 * offset;
      double minuteOffset = 0.80 * offset;
      double secondOffset = 0.00 * offset;

      double hourRadiusOutline   = 2 * ( radius - hourOffset );
      double minuteRadiusOutline = 2 * ( radius - minuteOffset );
      double secondRadiusOutline = 2 * ( radius - secondOffset );

      double endHourOutlineAngle   = ( 30 * ( dateTime.hour % 12 ) + 0.5 * dateTime.minute) * pi / 180;
      double endMinuteOutlineAngle = 6 * dateTime.minute * pi / 180;
      double endSecondOutlineAngle = 6 * dateTime.second * pi / 180;

      canvas.drawArc(Rect.fromLTWH(hourOffset,   hourOffset,   hourRadiusOutline,   hourRadiusOutline   ), - pi / 2, endHourOutlineAngle,   false, hourOutlineBrush);
      canvas.drawArc(Rect.fromLTWH(minuteOffset, minuteOffset, minuteRadiusOutline, minuteRadiusOutline ), - pi / 2, endMinuteOutlineAngle, false, minuteOutlineBrush);
      canvas.drawArc(Rect.fromLTWH(secondOffset, secondOffset, secondRadiusOutline, secondRadiusOutline ), - pi / 2, endSecondOutlineAngle, false, secondOutlineBrush);

      canvas.drawLine(center, Offset(secondX, secondY), secondBrush);
      canvas.drawLine(center, Offset(minuteX, minuteY), minuteBrush);
      canvas.drawLine(center, Offset(hourX, hourY), hourBrush);

      canvas.drawCircle(center, 5, centerFillBrush);

      double outerCircleRadius       = radius - 2.50 * offset;
      double bigInnerCircleRadius    = radius - 3.60 * offset;
      double smallInnerCircleRadius  = radius - 4.50 * offset;
      double degreeInnerCircleRadius = radius - 3.20 * offset;
      double textAngle               = pi / 6;
      
      canvas.save();
      canvas.translate(centerX, centerY);
      canvas.rotate(textAngle);

      List<String> labels = [ 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII' ];
      
      for (var element in labels) {
        final textSpan = TextSpan(
          text: element,
          style: TextStyle(
            color: labelColor,
            fontFamily: 'Times',
            fontSize: 12
          )
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            -textPainter.width * 0.5,
            -( 0.8 * radius - offset )
          ),
        );
        canvas.rotate( textAngle );
      }

      canvas.restore();

      String innerText = "L  E  O  N  A  M   T.   V.";
      final textSpan = TextSpan(
        text: innerText,
        style: TextStyle(
          color: watchColor,
          fontFamily: 'Times',
          fontSize: 10
        )
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          centerX - ( textPainter.width  / 2),
          centerY + 5 * offset
        ),
      );


      for ( double i = 0; i < 360; i += 1 ) {
        double x1 = centerX + outerCircleRadius * cos ( i * pi / 180 );
        double y1 = centerY + outerCircleRadius * sin ( i * pi / 180 );

        double x2 = centerX + degreeInnerCircleRadius * cos ( i * pi / 180 );
        double y2 = centerY + degreeInnerCircleRadius * sin ( i * pi / 180 );

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), degreeTracesBrush);

      }

      for ( double i = 0; i < 360; i += 6 ) {
        double x1 = centerX + outerCircleRadius * cos ( i * pi / 180 );
        double y1 = centerY + outerCircleRadius * sin ( i * pi / 180 );

        if ( i % 15 == 0 ) {
          double x2 = centerX + ( smallInnerCircleRadius ) * cos ( i * pi / 180 );
          double y2 = centerY + ( smallInnerCircleRadius ) * sin ( i * pi / 180 );
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourTraceBrush);
        } else {
          double x2 = centerX + bigInnerCircleRadius * cos ( i * pi / 180 );
          double y2 = centerY + bigInnerCircleRadius * sin ( i * pi / 180 );
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), secondTraceBrush);
        }

      }

      Paint paint = Paint()
        ..color = secondsCircleColor
        ..strokeWidth = 2
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(secondX, secondY);
      canvas.rotate(secondAngle);
      canvas.drawPath(getTrianglePath(6.0), paint);
      canvas.restore();

      paint.color = minuteCircleColor;

      canvas.save();
      canvas.translate(minuteX, minuteY);
      canvas.rotate(minuteAngle);
      canvas.drawPath(getTrianglePath(6.0), paint);
      canvas.restore();

      paint.color = hourCircleColor;

      canvas.save();
      canvas.translate(hourX, hourY);
      canvas.rotate(hourAngle);
      canvas.drawPath(getTrianglePath(6.0), paint);
      canvas.restore();

  }

  Path getTrianglePath( double size ) {
    return Path()
      ..moveTo( 0, - size/ 2 )
      ..lineTo( size * sqrt(3) / 2, 0 )
      ..lineTo( 0, size / 2 )
      ..lineTo( 0, - size / 2 );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}