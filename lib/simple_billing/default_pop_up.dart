part of simple_code;

class _DefaultBillingPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Platform.isIOS
                  ? const Color(0xff017bff)
                  : const Color(0xff00a273),
            ),
          ),
        ),
      ),
    );
  }
}
