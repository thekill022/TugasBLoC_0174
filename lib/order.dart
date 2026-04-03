import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagement/detail_order.dart';
import 'package:statemanagement/mainlayout.dart';
import 'package:statemanagement/order_bloc.dart';
import 'package:statemanagement/order_event.dart';
import 'package:statemanagement/order_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController makananController = TextEditingController();
  final TextEditingController minumanController = TextEditingController();
  final TextEditingController jumlahMakananController = TextEditingController();
  final TextEditingController jumlahMinumanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    makananController.dispose();
    minumanController.dispose();
    jumlahMakananController.dispose();
    jumlahMinumanController.dispose();
    super.dispose();
  }

  Widget _buildInputDecoration({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String errorMessage,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: MainLayout.labelColor),
        prefixIcon: Icon(icon, color: MainLayout.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: MainLayout.inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: MainLayout.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: MainLayout.inputFillColor,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if(state is OrderSuccess) {
          Navigator.push(
              context,
            MaterialPageRoute(builder: (_) => DetailOrderPage(
                makanan: state.makanan,
                minuman: state.minuman,
                jumlahMakanan: state.jumlahMakanan,
                jumlahMinuman: state.jumlahMinuman,
                totalHarga: state.totalHarga))
          );
        } else if(state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent,)
          );
        }
      },
      child: MainLayout(
        title: 'Order Menu',
        showAppBar: true,
        child: Container(
          color: MainLayout.backgroundColor,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "What would you like to have?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MainLayout.textTitleColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Fill in the details below to complete your order.",
                      style: TextStyle(
                        fontSize: 14,
                        color: MainLayout.textSubtitleColor,
                      ),
                    ),
                    SizedBox(height: 32),

                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.fastfood_rounded,
                                color: MainLayout.accentOrange,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Food Details",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MainLayout.textTitleColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          _buildInputDecoration(
                            controller: makananController,
                            label: "Food Name",
                            icon: Icons.lunch_dining_rounded,
                            errorMessage: "Please enter your food order",
                          ),
                          SizedBox(height: 16),

                          _buildInputDecoration(
                            controller: jumlahMakananController,
                            label: "Quantity (Food)",
                            icon: Icons.format_list_numbered_rounded,
                            errorMessage: "Please enter your food quantity",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.fastfood_rounded,
                                color: MainLayout.accentOrange,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Drink Details",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MainLayout.textTitleColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          _buildInputDecoration(
                            controller: minumanController,
                            label: "drink Name",
                            icon: Icons.lunch_dining_rounded,
                            errorMessage: "Please enter your drink order",
                          ),
                          SizedBox(height: 16),

                          _buildInputDecoration(
                            controller: jumlahMinumanController,
                            label: "Quantity (Drink)",
                            icon: Icons.format_list_numbered_rounded,
                            errorMessage: "Please enter your drink quantity",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48),

                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        final isLoading = state is OrderLoading;
                        return ElevatedButton(
                          onPressed: isLoading? null : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<OrderBloc>().add(
                                OrderSubmitted(
                                    makanan: makananController.text,
                                    minuman: minumanController.text,
                                    jumlahMinuman: int.tryParse(jumlahMakananController.text) ?? 0,
                                    jumlahMakanan: int.tryParse(jumlahMinumanController.text) ?? 0)
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: MainLayout.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: MainLayout.primaryColor.withOpacity(0.5),
                          ),
                          child: isLoading ?
                              SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long_rounded),
                              SizedBox(width: 8),
                              Text(
                                "Place Order",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
