part of 'session_bloc.dart';

class SessionState extends Equatable {
  final UserModel? user;
  final bool isLoadingLogin;
  final List<Order> orders;

  const SessionState({
    this.user,
    this.isLoadingLogin = false,
    this.orders = const [],
  });

  SessionState copyWith({
    UserModel? user,
    bool? isLoadingLogin,
    List<Order>? orders,
  }) =>
      SessionState(
        user: user ?? this.user,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
        orders: orders ?? this.orders,
      );

  @override
  List<Object?> get props => [
        user,
        isLoadingLogin,
        orders,
      ];
}
