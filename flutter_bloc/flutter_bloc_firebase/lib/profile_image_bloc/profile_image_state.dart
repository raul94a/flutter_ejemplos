// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileImageState {
  final bool loading;
  final String url;
  ProfileImageState({
    required this.loading,
    required this.url,
  });

  ProfileImageState copyWith({
    bool? loading,
    String? url,
  }) {
    return ProfileImageState(
      loading: loading ?? this.loading,
      url: url ?? this.url,
    );
  }
}
