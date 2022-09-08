
import 'package:flutter/material.dart';

class Transaction {
  String eId;
  String title;
  double amount;
  DateTime date;

  Transaction({
    required this.eId,
    required this.title,
    required this.amount,
    required this.date});
  
}