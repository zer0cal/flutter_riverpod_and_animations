library my_models;

class AnimatedBoxModel {
  AnimatedBoxModel();
  int _hexColor = 0xff50a0f0;
  int get hexColor => _hexColor;

  void setHexColor(int hexValue) {
    _hexColor = hexValue;
  }
}
