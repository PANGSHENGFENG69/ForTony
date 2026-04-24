part of tonydemo.lib;

class TonyLayout extends StatefulWidget {
  const TonyLayout({super.key, required this.vm, required this.child});

  final HomePageVM vm;
  final Widget child;

  @override
  State<TonyLayout> createState() => _TonyLayoutState();
}

class _TonyLayoutState extends State<TonyLayout> {
  static const _tabs = [
    (
      label: 'Home',
      icon: Icons.home_outlined,
      active: Icons.home,
      path: '/home',
    ),
    (
      label: 'Profile',
      icon: Icons.person_outlined,
      active: Icons.person,
      path: '/profile',
    ),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _tabs.indexWhere((t) => location.startsWith(t.path));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[currentIndex].label),
        centerTitle: false,
        elevation: 0,
      ),
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_tabs[index].path),
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.active),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

Future<void> showAlertDialog({
  String title = "",
  String content = "",
  String btnText = "好",
  VoidCallback? onPressed,
}) {
  return showGeneralDialog(
    context: rootNavigatorKey.currentContext!,
    barrierDismissible: false,
    barrierLabel: 'Alert',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (dialogContext, _, __) {
      final size = MediaQuery.of(dialogContext).size;

      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 420, // 👈 better for tablet/web
              maxHeight: size.height * 0.7,
            ),
            child: _buildDialogContent(
              dialogContext,
              title,
              content,
              btnText,
              onPressed,
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);

      final scale = Tween<double>(
        begin: 0.92,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack));

      final slide = Tween<Offset>(
        begin: const Offset(0, 0.05),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: ScaleTransition(scale: scale, child: child),
        ),
      );
    },
  );
}

Widget _buildDialogContent(
  BuildContext context,
  String title,
  String content,
  String btnText,
  VoidCallback? onPressed,
) {
  return Material(
    color: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // 👈 match your app
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // 👈 softer shadow
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== TITLE =====
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: -12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff1a1a1a),
                ),
              ),
            ),

          // ===== CONTENT =====
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: -2, color: Colors.black87),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ===== BUTTON =====
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(); // ✅ correct
                onPressed?.call(); // no pop inside callback
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5F1985), // 👈 your brand color
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                btnText,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

CustomTransitionPage fadePage({required LocalKey key, required Widget child}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    reverseTransitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: const Interval(0.5, 1.0, curve: Curves.linear),
        ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: secondaryAnimation,
              curve: const Interval(0.0, 0.5, curve: Curves.linear),
            ),
          ),
          child: child,
        ),
      );
    },
  );
}
