import 'package:devtools_app/screens/data_preparing.dart';
import 'package:devtools_app/screens/magic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/drawing.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: const [
      Drawing(),
      DataPreparing(),
      Magic(),
    ]);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // Always add properties from the base class first.
    super.debugFillProperties(properties);

    // properties.add(DoubleProperty(
    //   'device pixel ratio',
    //   devicePixelRatio,
    //   tooltip: 'physical pixels per logical pixel',
    // ));

    // Omit the property name 'message' when displaying this String property
    // // as it would just add visual noise.
    // properties.add(StringProperty('message', message, showName: false));

    // properties.add(DoubleProperty('stepWidth', stepWidth));

    // // A scale of 1.0 does nothing so should be hidden.
    // properties.add(DoubleProperty('scale', scale, defaultValue: 1.0));

    // // If the hitTestExtent matches the paintExtent, it is just set to its
    // // default value so is not relevant.
    // properties.add(DoubleProperty('hitTestExtent', hitTestExtent, defaultValue: paintExtent));

    // // maxWidth of double.infinity indicates the width is unconstrained and
    // // so maxWidth has no impact.
    // properties.add(DoubleProperty('maxWidth', maxWidth, defaultValue: double.infinity));

    // Progress is a value between 0 and 1 or null. Showing it as a
    // percentage makes the meaning clear enough that the name can be
    // hidden.
    // properties.add(PercentProperty(
    //   'progress',
    //   progress,
    //   showName: false,
    //   ifNull: '<indeterminate>',
    // ));

    // // Most text fields have maxLines set to 1.
    // properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));

    // // Specify the unit as otherwise it would be unclear that time is in
    // // milliseconds.
    // properties.add(IntProperty('duration', duration.inMilliseconds, unit: 'ms'));

    // Tooltip is used instead of unit for this case as a unit should be a
    // terse description appropriate to display directly after a number
    // without a space.

    // // Displaying the depth value would be distracting. Instead only display
    // // if the depth value is missing.
    // properties.add(ObjectFlagProperty<int>('depth', depth, ifNull: 'no depth'));

    // // bool flag that is only shown when the value is true.
    // properties.add(FlagProperty('using primary controller', value: primary));

    // properties.add(FlagProperty(
    //   'isCurrent',
    //   value: isCurrent,
    //   ifTrue: 'active',
    //   ifFalse: 'inactive',
    // ));

    // properties.add(DiagnosticsProperty<bool>('keepAlive', keepAlive));

    // // FlagProperty could have also been used in this case.
    // // This option results in the text "obscureText: true" instead
    // // of "obscureText" which is a bit more verbose but a bit clearer.
    // properties.add(DiagnosticsProperty<bool>('obscureText', obscureText, defaultValue: false));

    // properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
    // properties.add(EnumProperty<ImageRepeat>('repeat', repeat, defaultValue: ImageRepeat.noRepeat));

    // // Warn users when the widget is missing but do not show the value.
    // properties.add(ObjectFlagProperty<Widget>('widget', widget, ifNull: 'no widget'));

    // properties.add(IterableProperty<BoxShadow>(
    //   'boxShadow',
    //   boxShadow,
    //   defaultValue: null,
    //   style: style,
    // ));

    // // Getting the value of size throws an exception unless hasSize is true.
    // properties.add(DiagnosticsProperty<Size>.lazy(
    //   'size',
    //   () => size,
    //   description: '${ hasSize ? size : "MISSING" }',
    // ));

    // // If the `toString` method for the property value does not provide a
    // // good terse description, write a DiagnosticsProperty subclass as in
    // // the case of TransformProperty which displays a nice debugging view
    // // of a Matrix4 that represents a transform.
    // properties.add(TransformProperty('transform', transform));

    // // If the value class has a good `toString` method, use
    // // DiagnosticsProperty<YourValueType>. Specifying the value type ensures
    // // that debugging tools always know the type of the field and so can
    // // provide the right UI affordances. For example, in this case even
    // // if color is null, a debugging tool still knows the value is a Color
    // // and can display relevant color related UI.
    // properties.add(DiagnosticsProperty<Color>('color', color));

    // // Use a custom description to generate a more terse summary than the
    // // `toString` method on the map class.
    // properties.add(DiagnosticsProperty<Map<Listenable, VoidCallback>>(
    //   'handles',
    //   handles,
    //   description: handles != null
    //     ? '${handles!.length} active client${ handles!.length == 1 ? "" : "s" }'
    //     : null,
    //   ifNull: 'no notifications ever received',
    //   showName: false,
    // ));
  }
}
