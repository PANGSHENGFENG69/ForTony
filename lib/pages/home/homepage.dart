part of tonydemo.lib;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomePageVM>().getDogs(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomePageVM>();
    final image = vm.dogData?.message ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Tony Demo')),
      body: Column(
        children: [
          if (vm.isSkeletonLoading)
            const CircularProgressIndicator()
          else if (image.isEmpty)
            const Text('沒資料')
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ), //自己試試看把 Image.network 換去 network image cache看看，
              // 連結 : https://pub.dev/packages/cached_network_image
            ),
        ],
      ),
    );
  }
}
