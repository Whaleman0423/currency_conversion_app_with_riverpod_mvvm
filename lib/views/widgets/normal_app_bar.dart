part of '../../utils/values.dart';

PreferredSizeWidget normalAppBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(title),
    toolbarHeight: 60,
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(10.0),
      child: Divider(height: 0, color: Colors.black),
    ),
    centerTitle: true,
    actions: [
      closeIconButton(context),
    ],
  );
}
