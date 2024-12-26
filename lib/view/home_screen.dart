import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrefrashtoken/cubit_product/product_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testrefrashtoken/service/serviceToken.dart';


class UserListPage extends StatelessWidget {
   UserListPage({Key? key}) : super(key: key);
  final storage = FlutterSecureStorage();
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(    
      create: (context) => ProductCubit(ApiService(AuthRepository(dio: dio, storage: storage)))..fetchUsers(), 
      child: Scaffold(
        appBar: AppBar(title: const Text('product')),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.product.length,
                itemBuilder: (context, index) {
                  final user = state.product[index];
                  return ListTile(
                    title: Text(user.nameAr.toString()),
                    subtitle: Text("")
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
