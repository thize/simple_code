part of simple_code;

class MultiStreamBuilder extends StatefulWidget {
  const MultiStreamBuilder(
      {Key key,
      @required this.streams,
      @required this.initialDatas,
      @required this.builder})
      : assert(streams.length > 0),
        assert(streams.length == initialDatas.length),
        super(key: key);
  final List<Stream<dynamic>> streams;
  final List<dynamic> initialDatas;
  final Widget Function(BuildContext context, List<AsyncSnapshot> snapshots)
      builder;

  @override
  _MultiStreamBuilderState createState() => _MultiStreamBuilderState();
}

class _MultiStreamBuilderState extends State<MultiStreamBuilder> {
  StreamBuilder streamsBuilder;
  List<AsyncSnapshot> snapshots = [];

  @override
  Widget build(BuildContext context) {
    if (snapshots.isEmpty) streamsBuilder = _buildStreamBuilder(0, context);
    return streamsBuilder;
  }

  Widget _buildStreamBuilder(int index, BuildContext context) {
    if (widget.streams.length == index) {
      return widget.builder(context, snapshots);
    }
    snapshots.add(null);
    return StreamBuilder(
      stream: widget.streams[index],
      initialData: widget.initialDatas[index],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        snapshots[index] = snapshot;
        return _buildStreamBuilder(index + 1, context);
      },
    );
  }
}
