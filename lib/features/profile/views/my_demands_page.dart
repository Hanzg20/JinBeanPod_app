import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDemandsPage extends StatelessWidget {
  const MyDemandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_demands'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 跳转到发布需求页面
              _showPublishDemandDialog(context);
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'ongoing_demands'.tr),
                Tab(text: 'completed_demands'.tr),
                Tab(text: 'cancelled_demands'.tr),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDemandList(context, DemandStatus.ongoing),
                  _buildDemandList(context, DemandStatus.completed),
                  _buildDemandList(context, DemandStatus.cancelled),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemandList(BuildContext context, DemandStatus status) {
    final demands = _getDemands(status);

    if (demands.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(height: 16),
            Text(
              'no_demands'.tr,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _showPublishDemandDialog(context);
              },
              icon: const Icon(Icons.add),
              label: Text('publish_demand'.tr),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: demands.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final demand = demands[index];
        return _buildDemandCard(context, demand);
      },
    );
  }

  Widget _buildDemandCard(BuildContext context, Demand demand) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // TODO: 跳转到需求详情页面
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: demand.status.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      demand.status.label.tr,
                      style: TextStyle(
                        color: demand.status.color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      demand.category,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    demand.time,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                demand.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                demand.description,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    demand.location,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '¥${demand.budget}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (demand.status == DemandStatus.ongoing) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        // TODO: 取消需求
                      },
                      child: Text('cancel_demand'.tr),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: 查看报价
                      },
                      child: Text('view_quotes'.tr),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showPublishDemandDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'publish_demand'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'demand_title'.tr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'demand_category'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    'housekeeping'.tr,
                    'repair'.tr,
                    'moving'.tr,
                    'education'.tr,
                    'other'.tr,
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'demand_description'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'demand_location'.tr,
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'demand_budget'.tr,
                    border: const OutlineInputBorder(),
                    prefixText: '¥ ',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: 提交需求
                      Get.back();
                    },
                    child: Text('submit_demand'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Demand> _getDemands(DemandStatus status) {
    switch (status) {
      case DemandStatus.ongoing:
        return [
          Demand(
            title: 'demand_title_1'.tr,
            description: 'demand_description_1'.tr,
            category: 'housekeeping'.tr,
            location: 'demand_location_1'.tr,
            budget: 200,
            time: '2024-03-20',
            status: DemandStatus.ongoing,
          ),
          Demand(
            title: 'demand_title_2'.tr,
            description: 'demand_description_2'.tr,
            category: 'repair'.tr,
            location: 'demand_location_2'.tr,
            budget: 500,
            time: '2024-03-19',
            status: DemandStatus.ongoing,
          ),
        ];
      case DemandStatus.completed:
        return [
          Demand(
            title: 'demand_title_3'.tr,
            description: 'demand_description_3'.tr,
            category: 'moving'.tr,
            location: 'demand_location_3'.tr,
            budget: 800,
            time: '2024-03-15',
            status: DemandStatus.completed,
          ),
        ];
      case DemandStatus.cancelled:
        return [
          Demand(
            title: 'demand_title_4'.tr,
            description: 'demand_description_4'.tr,
            category: 'education'.tr,
            location: 'demand_location_4'.tr,
            budget: 300,
            time: '2024-03-10',
            status: DemandStatus.cancelled,
          ),
        ];
    }
  }
}

enum DemandStatus {
  ongoing(Colors.blue, 'demand_status_ongoing'),
  completed(Colors.green, 'demand_status_completed'),
  cancelled(Colors.grey, 'demand_status_cancelled');

  const DemandStatus(this.color, this.label);
  final Color color;
  final String label;
}

class Demand {
  final String title;
  final String description;
  final String category;
  final String location;
  final double budget;
  final String time;
  final DemandStatus status;

  Demand({
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.budget,
    required this.time,
    required this.status,
  });
} 