part of tonydemo.lib;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
        const SizedBox(height: 16),
        const Text(
          'Tony',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('tony@example.com', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 32),
        ListTile(leading: const Icon(Icons.settings), title: const Text('設定')),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('通知'),
        ),
        ListTile(leading: const Icon(Icons.logout), title: const Text('登出')),
      ],
    );
  }
}
