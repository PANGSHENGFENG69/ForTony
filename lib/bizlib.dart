library tonydemo.lib;

// packages
import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entities/response/index.dart';
import 'package:flutter_demo/main.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

//pages
part 'pages/home/homepage.dart';
part 'pages/profile/profilepage.dart';

//vm
part 'vm/homepage_vm.dart';
part 'vm/profilepage_vm.dart';

//biz
part 'biz/homepage_biz.dart';

//common
part 'common/tools.dart';
part 'common/shared_key.dart';
part 'common/utils.dart';

//components
part 'components/globalUse.dart';

//services
part 'services/api_service.dart';
part 'services/api_client.dart';
part 'services/auth_interceptor.dart';
part 'services/cache_interceptor.dart';
part 'services/retry_interceptor.dart';
