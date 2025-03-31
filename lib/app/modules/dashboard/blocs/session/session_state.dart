part of 'session_bloc.dart';

class SessionState extends Equatable {
  final UserModel? user;
  final bool isLoadingLogin;

  const SessionState({
    this.user,
    this.isLoadingLogin = false,
  });

  SessionState copyWith({
    UserModel? user,
    bool? isLoadingLogin,
  }) =>
      SessionState(
        user: user ?? this.user,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      );

  @override
  List<Object?> get props => [
        user,
        isLoadingLogin,
      ];
}
