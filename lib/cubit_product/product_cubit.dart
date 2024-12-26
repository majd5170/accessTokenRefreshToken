import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testrefrashtoken/model/product_model.dart';
import 'package:testrefrashtoken/service/serviceToken.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;
  ProductCubit(this.apiService) : super(ProductInitial());

  void fetchUsers() async {
    try {
      emit(ProductLoading());  
      final users = await apiService.fetchUsers();
      emit(ProductLoaded(users));  
    } catch (e) {
      emit(ProductError(e.toString()));  
    }
  }
}
