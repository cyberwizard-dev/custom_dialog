# custom_dialog

A customizable Flutter package for displaying beautiful and animated success, error, and warning dialogs.

## Features

*   **Customizable Dialog Types:** Easily display success, error, or warning dialogs.
*   **Animated Entry:** Dialogs animate into view for a smooth user experience.
*   **Customizable Buttons:** Set custom text for confirm and cancel buttons.
*   **Rounded Corners:** Option to display dialogs with rounded corners.
*   **Simple API:** A straightforward static method to show dialogs.

## Getting started

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  custom_dialog: ^1.0.0
```

Then, run `flutter pub get` to install the package.

## Usage

Import the package:

```dart
import 'package:custom_dialog/custom_dialog.dart';
```

To show a success dialog:

```dart
CustomDialog.showCustomDialog(
  context: context,
  dialogType: CustomDialogType.success,
  title: 'Success!',
  description: 'Your operation was completed successfully.',
  onConfirm: () {
    // Handle confirm action
    print('Success confirmed!');
  },
);
```

To show an error dialog with a cancel button:

```dart
CustomDialog.showCustomDialog(
  context: context,
  dialogType: CustomDialogType.error,
  title: 'Error!',
  description: 'Something went wrong. Please try again.',
  onConfirm: () {
    // Handle confirm action
    print('Error acknowledged!');
  },
  onCancel: () {
    // Handle cancel action
    print('Error cancelled!');
  },
  confirmButtonText: 'Got It',
  cancelButtonText: 'Dismiss',
);
```

To show a warning dialog without rounded corners:

```dart
CustomDialog.showCustomDialog(
  context: context,
  dialogType: CustomDialogType.warning,
  title: 'Warning!',
  description: 'This action cannot be undone.',
  onConfirm: () {
    // Handle confirm action
    print('Warning confirmed!');
  },
  rounded: false,
);
```

## Additional information

For more information, to contribute, or to file issues, please visit the GitHub repository: [https://github.com/cyberwizard-dev/custom_dialog](https://github.com/cyberwizard-dev/custom_dialog)