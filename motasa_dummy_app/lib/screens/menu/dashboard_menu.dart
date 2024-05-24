import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motasa_dummy_app/configs/functions/functions.dart';
import 'package:motasa_dummy_app/constant/constant.dart';

class DashboardMenu extends StatefulWidget {
  const DashboardMenu({super.key});

  @override
  State<DashboardMenu> createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> {
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController outletTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController addressTextController = TextEditingController();
  final TextEditingController postCodeTextController = TextEditingController();
  final TextEditingController cityTextController = TextEditingController();
  final FocusNode outletFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode postCodeFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final List<String> imageList = <String>[
    'https://cdns.klimg.com/resized/1200x600/p/headline/sasa-luncurkan-lagu-untuk-warga-dunia-s-b6144b.jpg',
    'https://id-live-01.slatic.net/p/56426666b5484dbcb6f4005dd0c78ce2.jpg',
    'https://assets.unileversolutions.com/v1/38774549.jpg',
  ];
  Uint8List? imageFile;
  Map? user;
  List cities = [];
  bool done = false;

  @override
  void initState() {
    super.initState();
    retrieveOutlets();
    retrieveCities();
  }

  Future<void> retrieveOutlets() async {
    try {
      Map? dataUser = await getExistingUser();
      final List outlets = await getCustomersOutlets();
      for (var outlet in outlets) {
        if (outlet["user_id"] == dataUser!["id"].toString()) {
          setState(() {
            user = dataUser;
            nameTextController.text = dataUser["name"];
            done = true;
          });
          break;
        }
      }
      setState(() {
        user = dataUser;
      });
    } catch (error) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        content: Text(error.toString()),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
    }
  }

  Future<void> retrieveCities() async {
    try {
      final List listCity = await getCities();
      setState(() {
        cities = listCity;
      });
    } catch (error) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        content: Text(error.toString()),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
    }
  }

  Future<void> saveOutlet() async {
    Get.dialog(Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(ImageTemplate.rocket),
            width: 200,
            height: 200,
          ),
          SizedBox(height: 4),
          Text(
            "Terima Kasih!",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: ColourTemplate.black,
              fontFamily: "Poppins",
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Data anda berhasil dikirim",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColourTemplate.black,
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    ));
    await Future.delayed(const Duration(seconds: 2), () => Get.back());
    setState(() {
      done = true;
    });
  }

  Future<void> getImage(String source) async {
    try {
      XFile? pickedImage = await imagePicker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedImage != null) {
        Uint8List decodedImage = await pickedImage.readAsBytes();
        setState(() {
          imageFile = decodedImage;
        });
        Get.back(); // close image source option dialog
      }
    } catch (error) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        content: Text(error.toString()),
        textConfirm: "Mengerti",
        buttonColor: Colors.transparent,
        confirmTextColor: ColourTemplate.blue,
        onConfirm: () => Get.back(),
      );
    }
  }

  void openImageDialog() {
    Get.defaultDialog(
      title: "Unggah Foto!",
      content: const Text("Pilih sumber foto!"),
      textCancel: "Kamera",
      textConfirm: "Galeri",
      buttonColor: Colors.transparent,
      confirmTextColor: ColourTemplate.blue,
      cancelTextColor: ColourTemplate.blue,
      onConfirm: () => getImage("gallery"),
      onCancel: () => getImage("camera"),
    );
  }

  Widget loadImage() {
    if (imageFile != null) {
      return Image(
        image: MemoryImage(imageFile!),
        fit: BoxFit.cover,
      );
    }
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(ImageTemplate.camera),
          width: 48,
          height: 48,
        ),
        SizedBox(height: 16),
        Text(
          "Tambahkan Foto",
          style: TextStyle(
            color: ColourTemplate.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "(Bisa ambil dari galeri/kamera)",
          style: TextStyle(
            color: ColourTemplate.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget loadContent() {
    if (done) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(ImageTemplate.desktop),
            width: 200,
            height: 200,
          ),
          SizedBox(height: 4),
          Text(
            "Halo!",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: ColourTemplate.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Kunjungi website untuk melihat data Anda http://...........",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColourTemplate.black,
            ),
          ),
        ],
      );
    }
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Mohon lengkapi data outlet',
            style: TextStyle(
              color: ColourTemplate.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          // *Outlet
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColourTemplate.white,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.store_mall_directory_outlined,
                  size: 32,
                  color: ColourTemplate.gray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: outletTextController,
                    focusNode: outletFocusNode,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nama Outlet",
                      hintStyle: TextStyle(
                        color: ColourTemplate.lightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // *Name
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColourTemplate.white,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 32,
                  color: ColourTemplate.gray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: nameTextController,
                    focusNode: nameFocusNode,
                    keyboardType: TextInputType.name,
                    readOnly: true,
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nama Pemilik",
                      hintStyle: TextStyle(
                        color: ColourTemplate.lightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // *Phone
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColourTemplate.white,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  size: 32,
                  color: ColourTemplate.gray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: phoneTextController,
                    focusNode: phoneFocusNode,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(15),
                    ],
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nomor Telepon",
                      hintStyle: TextStyle(
                        color: ColourTemplate.lightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // *Address
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColourTemplate.white,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 32,
                  color: ColourTemplate.gray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: addressTextController,
                    focusNode: addressFocusNode,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Alamat Lengkap",
                      hintStyle: TextStyle(
                        color: ColourTemplate.lightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // *Post Code
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColourTemplate.white,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.keyboard_alt_outlined,
                  size: 32,
                  color: ColourTemplate.gray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: postCodeTextController,
                    focusNode: postCodeFocusNode,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(7),
                    ],
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Kode Pos",
                      hintStyle: TextStyle(
                        color: ColourTemplate.lightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // *City
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColourTemplate.white,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.map_outlined,
                  size: 32,
                  color: ColourTemplate.gray,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: cityTextController,
                    focusNode: cityFocusNode,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: ColourTemplate.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Kabupaten/Kota",
                      hintStyle: TextStyle(
                        color: ColourTemplate.lightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // *Image Outlet
          const Text(
            'Upload foto outlet',
            style: TextStyle(
              color: ColourTemplate.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Visibility(
            visible: imageFile != null ? true : false,
            child: const SizedBox(height: 4),
          ),
          Visibility(
            visible: imageFile != null ? true : false,
            child: const Text(
              '(Ketuk foto untuk mengganti)',
              style: TextStyle(
                color: ColourTemplate.gray,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 5 / 3,
            child: GestureDetector(
              onTap: () => openImageDialog(),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: ColourTemplate.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: ColourTemplate.black.withOpacity(.25),
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: loadImage(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // *Outlet Coordinate
          const Text(
            'Ambil koordinat outlet',
            style: TextStyle(
              color: ColourTemplate.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: ColourTemplate.tosca,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: ColourTemplate.black.withOpacity(.25),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latitude",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "-",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Longitude",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "-",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      backgroundColor: ColourTemplate.lightGreen,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Refresh Koordinat",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // *Save Button
          ElevatedButton(
            onPressed: () => saveOutlet(),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: ColourTemplate.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
            ),
            child: const Text(
              "Simpan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourTemplate.background,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 48),
        shrinkWrap: true,
        children: [
          // *User greeting
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  child: Image(
                    image: AssetImage(ImageTemplate.profile),
                    width: 64,
                    height: 64,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selamat Datang,",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ColourTemplate.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user != null ? user!["name"] : "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColourTemplate.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            height: 148,
            child: PageView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) => Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: ColourTemplate.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.25),
                      offset: const Offset(2, 4),
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Image(
                  image: NetworkImage(imageList[index]),
                  height: 148,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: loadContent(),
          ),
        ],
      ),
    );
  }
}
