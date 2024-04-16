# Mô tả


Sử dụng một số trick do flutter cung cấp để xử lí xự kiện người dùng dừng ứng dụng 


# Tình huống: 

Có một bộ đếm thời gian Timer.periodic sau 1s tăng biến count lên 1. Nhưng khi ngưng sử dụng ứng dụng bằng cách nhấn nút home thì ứng dụng vẫn đang chạy tiếp.


# Giải quyết

Dựa vào AppLifecycleState enum do Flutter cung cấp để nắm bắt trạng thái của ứng dụng 

có 4 trạng thái chính :
    + Resumed : Trạng thái ứng dụng đang mở và người dùng có thể thao tác với ứng dụng
    
    + Detached : Trạng thái khi khởi động ban đầu ứng dụng và khi tắt ứng dụng

    + Inactive : Trạng thái ứng dụng được hiển thị nhưng người dùng không thao tác được với nó

    + Paused  : Trạng thái tạm dừng ứng dụng

=> Hướng giải quyết cho Widget chính kế thừa mixin WidgetsBindingObserver 

=> Đặt sự kiểm soát của WidgetsBindingObserver lên context hiện tại 

=> Khởi tạo hàm theo dõi 

=> Sử dụng trình theo dõi trạng thái hiện tại 

Ex: 
class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late Timer timer;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    //Create periodic
    timer = Timer.periodic(Duration(seconds: 1), (tm) {
      setState(() {
      if( SchedulerBinding.instance.lifecycleState == AppLifecycleState.resumed ){
         count++;
      }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      print('detached');
    }
    if (state == AppLifecycleState.inactive) {
      print('inactive');
    }
    if (state == AppLifecycleState.paused) {
      print('paused');
    }
    if (state == AppLifecycleState.resumed) {
      print('resumed');
    }
  }


 

# Nguồn tham khảo
https://api.flutter.dev/flutter/dart-ui/AppLifecycleState.html
