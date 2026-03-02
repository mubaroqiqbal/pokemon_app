import 'package:equatable/equatable.dart';
import 'package:pokemon_app/models/general_data_model.dart';

abstract class PokedexState extends Equatable {
  @override
  List get props => [];
}

class PokedexLoading extends PokedexState {}

class PokedexInitial extends PokedexState {}

class PokedexEmpty extends PokedexState {}

class PokedexError extends PokedexState {
  final String message;

  PokedexError(this.message);
}

class PokedexLoaded extends PokedexState {
  final int page;
  final List<GeneralDataModel> data;
  final bool hasMorePage;

  PokedexLoaded({this.data = const [], this.page = 0, this.hasMorePage = true});

  PokedexLoaded copyWith({
    int? page,
    List<GeneralDataModel>? data,
    bool? hasMorePage,
  }) {
    return PokedexLoaded(
      data: data ?? this.data,
      page: page ?? this.page,
      hasMorePage: hasMorePage ?? this.hasMorePage,
    );
  }

  @override
  List<Object?> get props => [page, data, hasMorePage];
}
