import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../controllers/service_request_controller.dart';
import '../models/service_request.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _budgetController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final List<String> _selectedCategories = [];

  final List<String> _availableCategories = [
    '清洁',
    '家政',
    '搬家',
    '维修',
    '教育',
    '美容美发',
    '健康护理',
    '其他',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _startDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _selectEndDate() async {
    if (_startDate == null) {
      Get.snackbar(
        'Error',
        'please_select_start_date_first'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!.add(const Duration(hours: 2)),
      firstDate: _startDate!,
      lastDate: _startDate!.add(const Duration(days: 90)),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _endDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategories.isEmpty) {
      Get.snackbar(
        'Error',
        'please_select_categories'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      Get.snackbar(
        'Error',
        'please_select_dates'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final request = ServiceRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // 临时ID
      userId: 'user1', // 临时用户ID
      title: _titleController.text,
      description: _descriptionController.text,
      categories: _selectedCategories,
      location: _locationController.text,
      expectedStartDate: _startDate!,
      expectedEndDate: _endDate!,
      budget: double.parse(_budgetController.text),
      status: ServiceRequestStatus.pending,
      createdAt: DateTime.now(),
    );

    final controller = Get.find<ServiceRequestController>();
    final success = await controller.createServiceRequest(request);
    if (success) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create_service_request'.tr),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'request_title'.tr,
                  hintText: 'request_title_hint'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_title'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // 描述
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'request_description'.tr,
                  hintText: 'request_description_hint'.tr,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_description'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // 服务类别
              Text(
                'service_categories'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _availableCategories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16.h),

              // 地点
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'service_location'.tr,
                  hintText: 'service_location_hint'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_location'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // 预算
              TextFormField(
                controller: _budgetController,
                decoration: InputDecoration(
                  labelText: 'service_budget'.tr,
                  hintText: 'service_budget_hint'.tr,
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please_enter_budget'.tr;
                  }
                  if (double.tryParse(value) == null) {
                    return 'please_enter_valid_budget'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // 时间选择
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('start_time'.tr),
                      subtitle: Text(
                        _startDate == null
                            ? 'select_start_time'.tr
                            : DateFormat('MM/dd HH:mm').format(_startDate!),
                      ),
                      onTap: _selectStartDate,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('end_time'.tr),
                      subtitle: Text(
                        _endDate == null
                            ? 'select_end_time'.tr
                            : DateFormat('MM/dd HH:mm').format(_endDate!),
                      ),
                      onTap: _selectEndDate,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // 提交按钮
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text('submit_request'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 