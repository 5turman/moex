import 'package:com.example.moex/core/view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:kiwi/kiwi.dart' as di;
import 'package:provider/provider.dart';

class ViewModelProvider<T extends ViewModel> extends StatelessWidget {
  const ViewModelProvider({@required this.builder}) : assert(builder != null);

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      builder: (context) {
        final container = Provider.of<di.Container>(context, listen: false);
        return container.resolve<T>();
      },
      dispose: (context, viewModel) => viewModel.dispose(),
      child: Consumer<T>(
        builder: (context, viewModel, _) => builder(context, viewModel),
      ),
    );
  }
}
