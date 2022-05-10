import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cars_entity.dart';
import '../cubits/cars_cubit.dart';
import '../cubits/cars_state.dart';
import '../widgets/image_view.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({Key? key}) : super(key: key);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('carlist-app-bar'),
        title: const Text('Cars List'),
      ),
      body: BlocBuilder<CarsCubit, CarsState>(
        builder: (context, state) {
          if (state is CarsLoadingState) {
            return const Center(
              key: Key('circular-progress-indicator'),
              child: CircularProgressIndicator(),
            );
          } else if (state is CarsLoadedState) {
            return ListView.builder(
              key: const Key('cars-list'),
              itemCount: state.cars.length,
              itemBuilder: (_, index) {
                final car = state.cars[index];
                return _CarsTile(car: car);
              },
            );
          } else if (state is CarsErrorState) {
            return Center(
              key: const Key('cars-error-message'),
              child: Text(state.errorMessage),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _CarsTile extends StatelessWidget {
  const _CarsTile({
    Key? key,
    required this.car,
  }) : super(key: key);

  final CarsEntity car;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(car.name ?? ''),
      subtitle: Text(car.description ?? ''),
      leading: SizedBox(
        height: 100,
        width: 50,
        child: ImageView(imageProvider: NetworkImage(car.photoUrl ?? '')),
      ),
    );
  }
}
