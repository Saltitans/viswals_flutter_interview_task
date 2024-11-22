import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useDebounceSearch({
  required TextEditingController controller,
  required void Function(String) onDebounce,
}) {
  final debounceTimer = useState<Timer?>(null);

  useEffect(
    () {
      void contentReaction() {
        if (debounceTimer.value?.isActive ?? false) {
          debounceTimer.value?.cancel();
        }

        debounceTimer.value = Timer(
          const Duration(milliseconds: 500),
          () => onDebounce.call(controller.text),
        );
      }

      controller.addListener(contentReaction);

      return () {
        controller.removeListener(contentReaction);
        debounceTimer.value?.cancel();
      };
    },
    [controller],
  );
}
