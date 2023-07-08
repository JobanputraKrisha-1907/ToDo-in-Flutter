import 'package:flutter/material.dart';

Card reuseCard(String title,Color iconBgColor,String time,IconData iconData, iconColor)
{
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: Color(0xff2a2e3d),
    child: Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          height: 33,
          width: 36,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(iconData,color: iconColor,),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Text(time,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}