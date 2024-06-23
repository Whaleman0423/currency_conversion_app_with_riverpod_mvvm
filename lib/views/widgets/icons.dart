part of '../../utils/values.dart';

Widget closeIconButton(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.close),
    onPressed: () {
      context.pop();
    },
  );
}
