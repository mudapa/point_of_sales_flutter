import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../cubit/auth_cubit/auth_cubit.dart';

AuthCubit authCubit(BuildContext context) => context.read<AuthCubit>();

CollectionReference get userRef =>
    FirebaseFirestore.instance.collection('users');

CollectionReference get productRef =>
    FirebaseFirestore.instance.collection('products');

CollectionReference get cartRef =>
    FirebaseFirestore.instance.collection('carts');

FirebaseAuth get auth => FirebaseAuth.instance;

Box get settings => Hive.box('settings');
