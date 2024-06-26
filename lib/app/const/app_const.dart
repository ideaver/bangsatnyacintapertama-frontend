import 'package:bangsatnyacintapertama_graphql_client/schema/generated/schema.graphql.dart';
import 'package:flutter/material.dart';

import '../../model/menu_item_model.dart';
import '../theme/app_colors.dart';

List<MenuItemModel> actionDropdownItems = [
  MenuItemModel(
    value: "MASS_ACTION",
    text: 'Aksi Massal',
    icon: const Icon(
      Icons.send,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "DELETE",
    text: 'Hapus',
    icon: const Icon(
      Icons.cancel_outlined,
      size: 14,
    ),
  ),
];

List<MenuItemModel> statusDropdownItems = [
  ...confirmationStatusDropdownItems,
  ...invitationStatusDropdownItems,
];

List<MenuItemModel> confirmationStatusDropdownItems = [
  MenuItemModel(
    value: Enum$ConfirmationStatus.REJECTED.name,
    text: 'Tidak Hadir',
    icon: const Icon(
      Icons.circle,
      color: AppColors.red,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$ConfirmationStatus.CONFIRMED.name,
    text: 'Hadir',
    icon: const Icon(
      Icons.circle,
      color: AppColors.greenLv1,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$ConfirmationStatus.UNCONFIRMED.name,
    text: 'Belum RSVP',
    icon: const Icon(
      Icons.circle,
      color: AppColors.yellow,
      size: 14,
    ),
  ),
];

List<MenuItemModel> invitationStatusDropdownItems = [
  MenuItemModel(
    value: "READ",
    text: 'Dibaca',
    icon: const Icon(
      Icons.remove_red_eye_outlined,
      color: AppColors.base,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "SENT",
    text: 'Terkirim',
    icon: const Icon(
      Icons.check,
      color: AppColors.base,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "QUEUE",
    text: 'Pending',
    icon: const Icon(
      Icons.access_time,
      color: AppColors.base,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "ALL",
    text: 'Semua',
    icon: const Icon(
      Icons.people_alt_outlined,
      color: AppColors.base,
      size: 14,
    ),
  ),
];

List<MenuItemModel> checkInActionDropdownItems = [
  MenuItemModel(
    value: "CHECK_IN",
    text: 'Check-In',
    icon: const Icon(
      Icons.exit_to_app_rounded,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "CANCEL_CHECK_IN",
    text: 'Batalkan Check-In',
    icon: const Icon(
      Icons.cancel_outlined,
      size: 14,
    ),
  ),
];

List<MenuItemModel> checkInSortirDropdownItems = [
  MenuItemModel(
    value: "CATEGORY",
    text: 'Urutkan Kategori',
    icon: const Icon(
      Icons.person_outline,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "SUB_CATEGORY",
    text: 'Urutkan Sub Kategori',
    icon: const Icon(
      Icons.person_outline,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "NAME",
    text: 'Urutkan Nama',
    icon: const Icon(
      Icons.card_membership_rounded,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: "RECENT",
    text: 'Terbaru',
    icon: const Icon(
      Icons.fullscreen_exit_rounded,
      size: 14,
    ),
  ),
];

List<MenuItemModel> guestSortirDropdownItems = [
  MenuItemModel(
    value: Enum$SortOrder.asc.name,
    text: 'Name Ascending',
    icon: const Icon(
      Icons.person_outline,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.desc.name,
    text: 'Name Descending',
    icon: const Icon(
      Icons.person_outline,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.asc.name,
    text: 'Seat Ascending',
    icon: const Icon(
      Icons.chair,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.desc.name,
    text: 'Seat Descending',
    icon: const Icon(
      Icons.chair,
      size: 14,
    ),
  ),
];

List<MenuItemModel> guestScannedSortirDropdownItems = [
  MenuItemModel(
    value: Enum$SortOrder.asc.name,
    text: 'Name Ascending',
    icon: const Icon(
      Icons.person_outline,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.desc.name,
    text: 'Name Descending',
    icon: const Icon(
      Icons.person_outline,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.asc.name,
    text: 'Seat Ascending',
    icon: const Icon(
      Icons.chair,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.desc.name,
    text: 'Seat Descending',
    icon: const Icon(
      Icons.chair,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.asc.name,
    text: 'Scanned At Ascending',
    icon: const Icon(
      Icons.adf_scanner_outlined,
      size: 14,
    ),
  ),
  MenuItemModel(
    value: Enum$SortOrder.desc.name,
    text: 'Scanned At Descending',
    icon: const Icon(
      Icons.adf_scanner_outlined,
      size: 14,
    ),
  ),
];
