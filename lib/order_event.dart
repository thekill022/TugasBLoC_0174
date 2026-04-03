import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderSubmitted extends OrderEvent {
  final String makanan;
  final String minuman;
  final int jumlahMakanan;
  final int jumlahMinuman;
}