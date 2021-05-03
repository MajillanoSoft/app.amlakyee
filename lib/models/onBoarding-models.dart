class SliderModel{
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("وسيط لبيع وشراء العقارات والسيارات بكافة الأنواع");
  sliderModel.setTitle("أملاكي");
  sliderModel.setImageAssetPath("assets/img/01.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("ابحث عن  عقارات أو سيارات بسهولة وسرعة في تطبيقنا");
  sliderModel.setTitle("البحث بسهولة");
  sliderModel.setImageAssetPath("assets/img/02.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("أملاكي هي وسيط بين الوكلاء أصحاب العقارات والسيارات وبين المشترين");
  sliderModel.setTitle("توسط في بيع وشراء كافة أنواع العقارات والسيارات");
  sliderModel.setImageAssetPath("assets/img/03.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
//3
  sliderModel.setDesc("أملاكي لتوسط بيع وشراء العقارات بأنواعها والسيارات");
  sliderModel.setTitle("مرحبا بك في");
  sliderModel.setImageAssetPath("assets/img/welcome.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}