import 'package:com.example.moex/core/view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'object_graph.dart';

class ViewModelProvider<T extends ViewModel> extends StatelessWidget {
  const ViewModelProvider({@required this.builder}) : assert(builder != null);

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      builder: (context) {
        final resolver = Provider.of<ObjectResolver>(context, listen: false);
        return resolver.resolve<T>();
      },
      dispose: (context, viewModel) => viewModel.dispose(),
      child: Consumer<T>(
        builder: (context, viewModel, _) => builder(context, viewModel),
      ),
    );
  }
}
