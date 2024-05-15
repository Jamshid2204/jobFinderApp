import 'package:flutter/material.dart';
import 'package:jobfinderapp/models/request/agents/agents.dart';
import 'package:jobfinderapp/models/response/agent/get_agent.dart';
import 'package:jobfinderapp/models/response/jobs/jobs_response.dart';
import 'package:jobfinderapp/services/helpers/agent_helper.dart';

class AgentsNotifier extends ChangeNotifier {
  late List<Agents> allAgents;
  late Future<List<JobsResponse>> agentJobs;
  late Map<String, dynamic> chat;
  Agents? agent;

  Future<List<Agents>> getAgents(){
    var agents = AgentHelper.getAllAgents();
    return agents;
  }

  Future<GetAgent> getAgentInfo(String uid){
    var agent = AgentHelper.getAgentInfo(uid);
    return agent;
  }

  Future<List<JobsResponse>> getAgentJobs(String uid){
    agentJobs = AgentHelper.getAgentJobs(uid);
    return agentJobs;
  }
  
}
