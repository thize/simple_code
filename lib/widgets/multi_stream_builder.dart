part of simple_code;

class MultiStreamBuilder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    StreamBuilder streamsBuilder;
    List<AsyncSnapshot> snapshots = [];
    if (snapshots.isEmpty) {
      streamsBuilder = _buildStreamBuilder(0, context, snapshots);
    }
    return streamsBuilder;
  }

  Widget _buildStreamBuilder(
      int index, BuildContext context, List<AsyncSnapshot> snapshots) {
    snapshots.add(null);
    return StreamBuilder(
      stream: streams[index],
      initialData: initialDatas[index],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        snapshots[index] = snapshot;
        if (index == streams.length - 1) {
          return builder(context, snapshots);
        }
        return _buildStreamBuilder(index + 1, context, snapshots);
      },
    );
  }
}
